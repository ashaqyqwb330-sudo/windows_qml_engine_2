import os
import sys
import json
import time
from datetime import datetime

# Import PySide6 core elements
from PySide6.QtCore import QCoreApplication, QObject, Slot, Signal, QTimer, QByteArray
from PySide6.QtGui import QGuiApplication
from PySide6.QtNetwork import QLocalServer, QLocalSocket

# Import local Database Manager
try:
    from db_manager import DatabaseManager
except ImportError:
    # Handle if run from outside the main directory
    sys.path.append(os.path.dirname(os.path.abspath(__file__)))
    from db_manager import DatabaseManager

# Check for pywin32 availability for Windows Service compatibility
try:
    import win32serviceutil
    import win32service
    import win32event
    import servicemanager
    PYWIN32_AVAILABLE = True
except ImportError:
    PYWIN32_AVAILABLE = False


class ClipboardServiceServer(QObject):
    def __init__(self, db_dir):
        super().__init__()
        self.db = DatabaseManager(db_dir)
        self.server = QLocalServer()
        self.clients = []
        
        # Clipboard reference
        self.clipboard = QGuiApplication.clipboard()
        self.clipboard.dataChanged.connect(self.on_clipboard_changed)
        self.last_text = ""

        # Remove previous instances of the local server if any
        QLocalServer.removeServer("GoldenClipboardService")
        
        if self.server.listen("GoldenClipboardService"):
            print("QLocalServer listening on 'GoldenClipboardService'")
            self.server.newConnection.connect(self.on_new_connection)
            self.db.log_action("success", "🟢 خدمة الخلفية: تم تشغيل قناة الاتصال المحلية بنجاح.")
        else:
            print(f"QLocalServer failed to listen: {self.server.errorString()}")
            self.db.log_action("error", f"🔴 خدمة الخلفية: فشل بدء قناة الاتصال: {self.server.errorString()}")

    def on_new_connection(self):
        socket = self.server.nextPendingConnection()
        if socket:
            print("New client connected to GoldenClipboardService")
            self.clients.append(socket)
            socket.disconnected.connect(lambda: self.on_client_disconnected(socket))
            socket.readyRead.connect(lambda: self.on_client_ready_read(socket))
            
            # Send initial greeting/status
            self.send_to_socket(socket, {
                "event": "connected",
                "status": "active",
                "message": "مرحباً بك! خدمة الخلفية الذهبية متصلة ونشطة."
            })

    def on_client_disconnected(self, socket):
        print("Client disconnected")
        if socket in self.clients:
            self.clients.remove(socket)

    def on_client_ready_read(self, socket):
        data = socket.readAll().data().decode("utf-8")
        try:
            msg = json.loads(data)
            print(f"Received command from GUI app: {msg}")
            cmd = msg.get("command")
            if cmd == "ping":
                self.send_to_socket(socket, {"event": "pong"})
            elif cmd == "status":
                self.send_to_socket(socket, {
                    "event": "status_reply",
                    "status": "active",
                    "pid": os.getpid()
                })
        except Exception as e:
            print(f"Error parsing client command: {e}")

    def send_to_socket(self, socket, obj):
        try:
            payload = json.dumps(obj, ensure_ascii=False).encode("utf-8")
            socket.write(payload)
            socket.flush()
        except Exception as e:
            print(f"Error sending payload to socket: {e}")

    def broadcast(self, obj):
        payload = json.dumps(obj, ensure_ascii=False).encode("utf-8")
        for client in list(self.clients):
            try:
                client.write(payload)
                client.flush()
            except Exception as e:
                print(f"Failed to send to client, removing: {e}")
                self.clients.remove(client)

    def on_clipboard_changed(self):
        try:
            text = self.clipboard.text()
            if not text or text == self.last_text:
                return
            self.last_text = text
            
            # Check for directive
            is_builder = "@builder" in text
            is_executor = "@executor" in text
            is_treedoc = "@treedoc" in text
            
            if is_builder or is_executor or is_treedoc:
                print(f"Background service captured directive text: {text[:60]}")
                self.db.log_action("success", f"🤖 خدمة الخلفية: تم كشف توجيه نشط في الحافظة وتخزينه تلقائياً.")
                
                # Insert capturing log
                title = f"Background Directive: {text[:35]}..." if len(text) > 35 else f"Background Directive: {text}"
                self.db.add_capture(title, text, "clip_code", "", "gold")
                
                # Broadcast detection to all GUI clients
                self.broadcast({
                    "event": "directive_detected",
                    "message": "تم التقاط حزمة توجيهات برمجية في الخلفية تلقائياً!",
                    "text": text
                })
        except Exception as e:
            print(f"Error reading clipboard in background service: {e}")


# --- Traditional Windows NT Service Implementation ---
if PYWIN32_AVAILABLE:
    class ClipboardWindowsService(win32serviceutil.ServiceFramework):
        _svc_name_ = "GoldenClipboardService"
        _svc_display_name_ = "Golden Platform Clipboard Monitor Service"
        _svc_description_ = "Monitors clipboard for developer packages and automated directives in the background."

        def __init__(self, args):
            super().__init__(args)
            self.hWaitStop = win32event.CreateEvent(None, 0, 0, None)
            self.is_running = True

        def SvcStop(self):
            self.ReportServiceStatus(win32service.SERVICE_STOP_PENDING)
            win32event.SetEvent(self.hWaitStop)
            self.is_running = False

        def SvcDoRun(self):
            servicemanager.LogMsg(
                servicemanager.EVENTLOG_INFORMATION_TYPE,
                servicemanager.PYS_SERVICE_STARTED,
                (self._svc_name_, '')
            )
            self.main()

        def main(self):
            # When running inside service context, start our headless Qt application loop
            db_dir = os.path.dirname(os.path.abspath(__file__))
            app = QGuiApplication([])
            server = ClipboardServiceServer(db_dir)
            
            # Use QTimer to check for stop signal from NT service manager periodically
            timer = QTimer()
            timer.setInterval(1000)
            
            def check_stop():
                if not self.is_running:
                    app.quit()
                    
            timer.timeout.connect(check_stop)
            timer.start()
            
            app.exec()


def run_daemon():
    print("Starting Golden Clipboard Service as user-level background daemon...")
    db_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Write PID for clean process lifecycle management
    pid_file = os.path.join(db_dir, "service.pid")
    try:
        with open(pid_file, "w") as f:
            f.write(str(os.getpid()))
    except Exception as e:
        print(f"Error writing PID file: {e}")

    app = QGuiApplication(sys.argv)
    
    # Keep application running without a taskbar icon or main window
    app.setApplicationName("GoldenClipboardServiceDaemon")
    
    server = ClipboardServiceServer(db_dir)
    
    # Clean exit removal
    exit_code = app.exec()
    try:
        if os.path.exists(pid_file):
            os.remove(pid_file)
    except Exception:
        pass
    sys.exit(exit_code)


if __name__ == "__main__":
    # If arguments specify daemon, run direct background loop (ideal for standard users)
    if "--daemon" in sys.argv or not PYWIN32_AVAILABLE:
        run_daemon()
    else:
        # Otherwise run as Windows service installer/runner
        if len(sys.argv) == 1:
            # Standard run (service mode)
            servicemanager.Initialize()
            servicemanager.PrepareToHostSingle(ClipboardWindowsService)
            servicemanager.StartServiceCtrlDispatcher()
        else:
            win32serviceutil.HandleCommandLine(ClipboardWindowsService)
