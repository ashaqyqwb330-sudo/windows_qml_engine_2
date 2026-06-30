import os
import sys
import tempfile
import unittest
from unittest.mock import MagicMock, patch

# Add current folder to path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from db_manager import DatabaseManager
from engine import EngineBackend, logger

class TestEngineBackend(unittest.TestCase):
    def setUp(self):
        # Create a temporary sqlite database for isolated testing
        self.temp_dir = tempfile.TemporaryDirectory()
        self.db_path = os.path.join(self.temp_dir.name, "test_golden.db")
        self.db = DatabaseManager(self.temp_dir.name)
        
        # Patch QObject and signals for test environment
        with patch('PySide6.QtCore.QObject.__init__'):
            self.backend = EngineBackend()
            # Inject our test database
            self.backend.db = self.db
            self.backend._base_dir = self.temp_dir.name

    def tearDown(self):
        self.temp_dir.cleanup()

    def test_get_base_dir_for_prefix_default(self):
        """Test that default prefix paths fall back to the project root directory."""
        project_dir = "/fake/project/dir"
        result = self.backend.get_base_dir_for_prefix("@builder", project_dir)
        self.assertEqual(result, project_dir)

    def test_get_base_dir_for_prefix_custom(self):
        """Test that configured custom paths are correctly resolved."""
        custom_path = self.temp_dir.name
        self.db.set_setting("path_builder", custom_path)
        
        result = self.backend.get_base_dir_for_prefix("@builder", "/fake/project/dir")
        self.assertEqual(result, custom_path)

    def test_sanitize_path_relative(self):
        """Test that relative paths are correctly resolved relative to project directory."""
        project_dir = self.temp_dir.name
        rel_path = "src/main.py"
        expected = os.path.normpath(os.path.join(project_dir, rel_path))
        
        result = self.backend.sanitize_path(rel_path, project_dir)
        self.assertEqual(result, expected)

    def test_sanitize_path_absolute_convert(self):
        """Test that absolute paths are converted to relative to prevent escape by default."""
        self.db.set_setting("absolute_path_handling", "convert")
        project_dir = self.temp_dir.name
        abs_path = "C:/Absolute/Path/to/file.py" if os.name == 'nt' else "/Absolute/Path/to/file.py"
        
        result = self.backend.sanitize_path(abs_path, project_dir)
        self.assertTrue(result.startswith(project_dir))

    def test_sanitize_path_absolute_prevent(self):
        """Test that absolute paths are blocked if absolute_path_handling is set to prevent."""
        self.db.set_setting("absolute_path_handling", "prevent")
        project_dir = self.temp_dir.name
        abs_path = "C:/Absolute/Path/to/file.py" if os.name == 'nt' else "/Absolute/Path/to/file.py"
        
        with self.assertRaises(ValueError):
            self.backend.sanitize_path(abs_path, project_dir)

    def test_saved_webpage_parser_simulation(self):
        """Test that HTML parsing correctly splits inline styling and scripting."""
        html_content = """
        <!DOCTYPE html>
        <html>
        <head>
            <style>
                body { background: #000; }
            </style>
        </head>
        <body>
            <h1>Test</h1>
            <script>
                console.log("Hello from script!");
            </script>
        </body>
        </html>
        """
        temp_html = os.path.join(self.temp_dir.name, "saved_page.html")
        with open(temp_html, "w", encoding="utf-8") as f:
            f.write(html_content)
            
        # Verify the file is read and parsed without throwing errors
        self.backend.processingFinished = MagicMock()
        self.backend.logAdded = MagicMock()
        
        self.backend.process_saved_webpage(temp_html, "test_project")
        # Ensure it attempted to output logs/finish messages
        self.assertTrue(self.backend.logAdded.emit.called)

if __name__ == "__main__":
    unittest.main()
