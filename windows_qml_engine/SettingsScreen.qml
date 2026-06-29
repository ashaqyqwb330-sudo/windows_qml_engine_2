import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

Rectangle {
    id: root
    color: "transparent"

    // Self-contained translation database for modularity
    function getTxt(key) {
        var translations = {
            "title": { "ar": "📊 لوحة التحكم والإعدادات المتقدمة", "en": "📊 Advanced Preferences & Settings" },
            "desc": { "ar": "قم بتخصيص سلوك محرك المنصة الذهبية وأتمتة الحافظة، وإعداد المطور ومستويات الالتقاط الذكي وصناعة الحزم.", "en": "Customize Golden Platform engine behavior, clipboard automations, developer options, and smart capturing." },
            
            // Sections
            "sec_general": { "ar": "⚙️ الإعدادات العامة والبيئة", "en": "⚙️ General Settings & Environment" },
            "sec_prefixes": { "ar": "🏷️ البادئات والرموز البرمجية", "en": "🏷️ Directives & Prefixes" },
            "sec_developer": { "ar": "🛠️ وضع المطور والخيارات الفنية", "en": "🛠️ Developer Mode & Code Standards" },
            "sec_build_pack": { "ar": "📦 حزمة البناء والمستودعات", "en": "📦 Build Pack Packaging Options" },
            "sec_smart_capture": { "ar": "🧠 الالتقاط الذكي وتجميل المستندات", "en": "🧠 Smart Capture & Visual Beautifier" },
            "sec_about": { "ar": "👑 حول المنصة والترخيص", "en": "👑 Platform Verification & Diagnostics" },

            // General Controls
            "lang_lbl": { "ar": "لغة الواجهة الرسومية:", "en": "Interface Language:" },
            "theme_lbl": { "ar": "سمة المظهر والنمط المرئي:", "en": "Visual UI Theme:" },
            "base_dir_lbl": { "ar": "مجلد العمل الافتراضي النشط:", "en": "Default Active Work Directory:" },
            "bubble_lbl": { "ar": "الفقاعة العائمة أعلى النوافذ:", "en": "Floating Golden Overlay Bubble:" },
            "clip_monitor_lbl": { "ar": "المعالجة التلقائية للحافظة:", "en": "Automatic Clipboard Processing:" },
            "clear_clip_lbl": { "ar": "مسح الحافظة بعد الحفظ الناجح:", "en": "Clear Clipboard after successful extraction:" },
            "btn_browse": { "ar": "استعراض 📂", "en": "Browse 📂" },

            // Prefixes Controls
            "prefix_builder_lbl": { "ar": "بادئة منشئ الملفات (@builder):", "en": "Builder Directive Prefix (@builder):" },
            "prefix_executor_lbl": { "ar": "بادئة منفذ الأوامر (@executor):", "en": "Executor Directive Prefix (@executor):" },
            "prefix_treedoc_lbl": { "ar": "بادئة التقارير الشجرية (@treedoc):", "en": "TreeDoc Directive Prefix (@treedoc):" },
            "btn_save_prefixes": { "ar": "حفظ وتفعيل البادئات 💾", "en": "Save & Apply Prefixes 💾" },

            // Developer Controls
            "dev_mode_lbl": { "ar": "تفعيل وضع المطور المتقدم (Developer Mode):", "en": "Enable Advanced Developer Mode:" },
            "context_mgr_lbl": { "ar": "مدير سياق المشروع التلقائي:", "en": "Project Context Manager (Auto-track):" },
            "folder_naming_lbl": { "ar": "نمط تسمية المجلدات الجديدة:", "en": "Folder Naming Style Strategy:" },
            "file_naming_lbl": { "ar": "نمط تسمية الملفات المستخرجة:", "en": "File Naming Clean Strategy:" },
            "custom_template_lbl": { "ar": "قالب مخصص لتسمية الملفات:", "en": "Custom Naming Template:" },

            // Build Pack Controls
            "scan_mode_lbl": { "ar": "مسار مسح الملفات الافتراضي:", "en": "Default File Scan Target:" },
            "export_format_lbl": { "ar": "صيغة التصدير التلقائية للحزمة:", "en": "Auto Export Package Format:" },
            "include_non_code_lbl": { "ar": "تضمين الملفات غير البرمجية والمستندات:", "en": "Include non-code assets and docs:" },
            "include_subdirs_lbl": { "ar": "تضمين كافة المجلدات الفرعية:", "en": "Recursively scan subfolders:" },
            "wrapping_lbl": { "ar": "نمط تغليف الكود والنص:", "en": "Text/Code Wrapping Delimiter:" },
            "md_to_html_lbl": { "ar": "تحويل تقارير Markdown إلى صفحات HTML:", "en": "Render Markdown exports to rich HTML:" },

            // Smart Capture Controls
            "sc_enabled_lbl": { "ar": "تشغيل نظام الالتقاط الذكي الفوري:", "en": "Enable Smart Capture Engine:" },
            "sc_save_all_lbl": { "ar": "حفظ كافة النصوص الملتقطة في SQLite:", "en": "Automatically log all clips in SQLite:" },
            "sc_ignore_short_lbl": { "ar": "تجاهل النصوص والفقرات القصيرة جداً:", "en": "Ignore extremely short snippet feeds:" },
            "sc_apply_all_themes_lbl": { "ar": "تطبيق ومعاينة كافة السمات الجمالية:", "en": "Generate preview renders for all styles:" },
            "sc_auto_import_lbl": { "ar": "الاستيراد التلقائي للقوالب التنميطية:", "en": "Auto-import style sheet templates:" },
            "sc_default_theme_lbl": { "ar": "السمة واللون الافتراضي للمستندات المعالجة:", "en": "Default theme styling for documents:" },
            "sc_css_lbl": { "ar": "محرر التنسيق المرئي CSS المخصص للمستندات:", "en": "Custom Render CSS Stylesheet Override:" },
            "btn_preview_css": { "ar": "معاينة التنسيق 👁️", "en": "Preview Rendering Style 👁️" },

            // About Controls
            "about_p1": { "ar": "المنصة الذهبية الذكية للويندوز Pro - مساعدك المحمول للأتمتة الذكية والتحكم بنظام الملفات مع دعم فني للذكاء الاصطناعي ومراقب الحافظة الفوري وعازل أوامر آمن للغاية.", "en": "Golden Intelligent Platform Pro for Windows - Your high-performance portal for screen scraping, automated coding, directory layout packaging, and secure terminal emulation." },
            "about_p2": { "ar": "الترخيص: نسخة المطورين غير المحدودة (Enterprise Team). قاعدة البيانات المحلية نشطة ومحميّة.", "en": "License: Developer Enterprise Edition (Offline Protected DB). Secure environment fully validated." },
            "btn_help_center": { "ar": "📖 الانتقال إلى مركز المساعدة", "en": "📖 Open Help & Learning Center" },
            "btn_source_exporter": { "ar": "📤 تصدير الكود المصدري للتطبيق", "en": "📤 Self-Export Source Code" },
            
            // Extra
            "api_key_lbl": { "ar": "مفتاح Gemini API المؤمن والمشفر:", "en": "Encrypted Secure Gemini API Key:" },
            "btn_save_key": { "ar": "تأمين المفتاح 🔑", "en": "Secure API Key 🔑" },
            "sqlite_log_lbl": { "ar": "📜 سجل عمليات النظام الموثق في قاعدة البيانات:", "en": "📜 Operation & Database Event Log (SQLite):" },
            "btn_clear_logs": { "ar": "مسح السجلات 🧹", "en": "Clear Log History 🧹" }
        };
        var isAr = (backend.appLanguage === "ar");
        return translations[key] ? (isAr ? translations[key]["ar"] : translations[key]["en"]) : "";
    }

    // Flags to prevent writing during initialization
    property bool isLoaded: false

    Component.onCompleted: {
        loadSettingsFromBackend();
    }

    function loadSettingsFromBackend() {
        isLoaded = false;
        
        // General Controls
        baseDirInput.text = backend.baseDir;
        clearClipSwitch.checked = backend.get_setting("clear_clip_on_save", "false") === "true";

        // Prefixes
        prefixBuilderInput.text = backend.get_setting("prefix_builder", "@builder");
        prefixExecutorInput.text = backend.get_setting("prefix_executor", "@executor");
        prefixTreedocInput.text = backend.get_setting("prefix_treedoc", "@treedoc");

        // Developer Mode
        devModeSwitch.checked = backend.get_setting("dev_mode", "false") === "true";
        contextMgrSwitch.checked = backend.get_setting("project_context_manager", "false") === "true";
        folderNamingCombo.currentIndex = folderNamingCombo.find(backend.get_setting("folder_naming_pattern", "smart"));
        fileNamingCombo.currentIndex = fileNamingCombo.find(backend.get_setting("file_naming_pattern", "clean"));
        customNamingInput.text = backend.get_setting("custom_file_naming_template", "{filename}_{date}");

        // Build Pack
        scanModeCombo.currentIndex = scanModeCombo.find(backend.get_setting("build_pack_scan_mode", "active_project"));
        exportFormatCombo.currentIndex = exportFormatCombo.find(backend.get_setting("build_pack_export_format", "PLAIN"));
        includeNonCodeSwitch.checked = backend.get_setting("build_pack_include_non_code", "true") === "true";
        includeSubdirsSwitch.checked = backend.get_setting("build_pack_include_subdirs", "true") === "true";
        wrappingStyleCombo.currentIndex = wrappingStyleCombo.find(backend.get_setting("build_pack_wrapping_style", "smart"));
        mdToHtmlSwitch.checked = backend.get_setting("build_pack_markdown_to_html", "true") === "true";

        // Smart Capture
        scEnabledSwitch.checked = backend.get_setting("smart_capture_enabled", "true") === "true";
        scSaveAllSwitch.checked = backend.get_setting("smart_capture_save_all", "true") === "true";
        scIgnoreShortSwitch.checked = backend.get_setting("smart_capture_ignore_short", "false") === "true";
        scApplyAllSwitch.checked = backend.get_setting("smart_capture_apply_all_themes", "false") === "true";
        scAutoImportSwitch.checked = backend.get_setting("smart_capture_auto_import", "true") === "true";
        scDefaultThemeCombo.currentIndex = scDefaultThemeCombo.find(backend.get_setting("smart_capture_default_theme", "dark"));
        scCustomCssEdit.text = backend.get_setting("smart_capture_custom_css", "body { font-family: sans-serif; padding: 20px; background-color: #0f172a; color: #f1f5f9; }");

        geminiKeyEdit.text = backend.get_gemini_api_key();

        isLoaded = true;
    }

    function saveSetting(key, val) {
        if (isLoaded) {
            backend.set_setting(key, val);
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: parent.width - 20
        clip: true

        ColumnLayout {
            width: parent.width - 10
            spacing: 16
            anchors.margins: 10

            // Header Banner
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                color: cardSlateBg
                border.color: borderSlate
                border.width: 1
                radius: 10

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 15

                    Text {
                        text: "👑"
                        font.pixelSize: 42
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Text {
                            text: root.getTxt("title")
                            color: metallicGold
                            font.bold: true
                            font.pixelSize: 18
                        }
                        Text {
                            text: root.getTxt("desc")
                            color: textSilver
                            font.pixelSize: 12
                            wrapMode: Text.Wrap
                            Layout.fillWidth: true
                        }
                    }
                }
            }

            // SECTION 1: General Settings
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height + 20
                color: cardSlateBg
                border.color: borderSlate
                border.width: 1
                radius: 10

                ColumnLayout {
                    width: parent.width - 24
                    anchors.centerIn: parent
                    spacing: 12

                    Text {
                        text: root.getTxt("sec_general")
                        color: metallicGold
                        font.bold: true
                        font.pixelSize: 14
                    }

                    // Base Directory Selector
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        Text {
                            text: root.getTxt("base_dir_lbl")
                            color: textSilver
                            font.pixelSize: 11
                            Layout.preferredWidth: 160
                        }
                        TextField {
                            id: baseDirInput
                            Layout.fillWidth: true
                            color: textSilver
                            readOnly: true
                            background: Rectangle {
                                color: slateBg
                                border.color: borderSlate
                                radius: 4
                            }
                        }
                        Button {
                            text: root.getTxt("btn_browse")
                            onClicked: baseFolderDialog.open()
                        }
                    }

                    // Toggles Row
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 20

                        // Bubble toggle
                        RowLayout {
                            spacing: 8
                            Text { text: root.getTxt("bubble_lbl"); color: textSilver; font.pixelSize: 11 }
                            Switch {
                                checked: backend.bubbleEnabled
                                onCheckedChanged: {
                                    backend.bubbleEnabled = checked;
                                    bubbleOverlay.visible = checked;
                                }
                            }
                        }

                        // Clip Monitor Toggle
                        RowLayout {
                            spacing: 8
                            Text { text: root.getTxt("clip_monitor_lbl"); color: textSilver; font.pixelSize: 11 }
                            Switch {
                                checked: backend.get_clipboard_monitor_enabled()
                                onCheckedChanged: {
                                    backend.set_clipboard_monitor_enabled(checked);
                                }
                            }
                        }

                        // Clear Clip on Save
                        RowLayout {
                            spacing: 8
                            Text { text: root.getTxt("clear_clip_lbl"); color: textSilver; font.pixelSize: 11 }
                            Switch {
                                id: clearClipSwitch
                                onCheckedChanged: root.saveSetting("clear_clip_on_save", checked.toString())
                            }
                        }
                    }
                }
            }

            // SECTION 2: Prefixes Config
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height + 20
                color: cardSlateBg
                border.color: borderSlate
                border.width: 1
                radius: 10

                ColumnLayout {
                    width: parent.width - 24
                    anchors.centerIn: parent
                    spacing: 12

                    Text {
                        text: root.getTxt("sec_prefixes")
                        color: metallicGold
                        font.bold: true
                        font.pixelSize: 14
                    }

                    GridLayout {
                        columns: 2
                        columnSpacing: 15
                        rowSpacing: 8
                        Layout.fillWidth: true

                        Text { text: root.getTxt("prefix_builder_lbl"); color: textSilver; font.pixelSize: 11 }
                        TextField {
                            id: prefixBuilderInput
                            Layout.fillWidth: true
                            color: textSilver
                            background: Rectangle { color: slateBg; border.color: borderSlate; radius: 4 }
                        }

                        Text { text: root.getTxt("prefix_executor_lbl"); color: textSilver; font.pixelSize: 11 }
                        TextField {
                            id: prefixExecutorInput
                            Layout.fillWidth: true
                            color: textSilver
                            background: Rectangle { color: slateBg; border.color: borderSlate; radius: 4 }
                        }

                        Text { text: root.getTxt("prefix_treedoc_lbl"); color: textSilver; font.pixelSize: 11 }
                        TextField {
                            id: prefixTreedocInput
                            Layout.fillWidth: true
                            color: textSilver
                            background: Rectangle { color: slateBg; border.color: borderSlate; radius: 4 }
                        }
                    }

                    Button {
                        text: root.getTxt("btn_save_prefixes")
                        Layout.alignment: Qt.AlignRight
                        onClicked: {
                            backend.set_setting("prefix_builder", prefixBuilderInput.text.trim())
                            backend.set_setting("prefix_executor", prefixExecutorInput.text.trim())
                            backend.set_setting("prefix_treedoc", prefixTreedocInput.text.trim())
                            backend.notificationSent(backend.appLanguage === "ar" ? "تم الحفظ" : "Prefixes Saved", backend.appLanguage === "ar" ? "تم تحديث البادئات الآمنة لتطبيقات المطور بنجاح." : "Security prefixes updated in the engine store.", "success")
                        }
                    }
                }
            }

            // SECTION 3: Developer Settings
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height + 20
                color: cardSlateBg
                border.color: borderSlate
                border.width: 1
                radius: 10

                ColumnLayout {
                    width: parent.width - 24
                    anchors.centerIn: parent
                    spacing: 12

                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            text: root.getTxt("sec_developer")
                            color: metallicGold
                            font.bold: true
                            font.pixelSize: 14
                            Layout.fillWidth: true
                        }
                        Switch {
                            id: devModeSwitch
                            onCheckedChanged: root.saveSetting("dev_mode", checked.toString())
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        visible: devModeSwitch.checked

                        RowLayout {
                            spacing: 8
                            Text { text: root.getTxt("context_mgr_lbl"); color: textSilver; font.pixelSize: 11 }
                            Switch {
                                id: contextMgrSwitch
                                onCheckedChanged: root.saveSetting("project_context_manager", checked.toString())
                            }
                        }

                        GridLayout {
                            columns: 2
                            columnSpacing: 15
                            rowSpacing: 8
                            Layout.fillWidth: true

                            Text { text: root.getTxt("folder_naming_lbl"); color: textSilver; font.pixelSize: 11 }
                            ComboBox {
                                id: folderNamingCombo
                                model: ["smart", "first_line", "manual"]
                                Layout.fillWidth: true
                                onActivated: root.saveSetting("folder_naming_pattern", currentText)
                            }

                            Text { text: root.getTxt("file_naming_lbl"); color: textSilver; font.pixelSize: 11 }
                            ComboBox {
                                id: fileNamingCombo
                                model: ["clean", "raw", "custom"]
                                Layout.fillWidth: true
                                onActivated: root.saveSetting("file_naming_pattern", currentText)
                            }

                            Text { 
                                text: root.getTxt("custom_template_lbl")
                                color: textSilver
                                font.pixelSize: 11
                                visible: fileNamingCombo.currentText === "custom"
                            }
                            TextField {
                                id: customNamingInput
                                Layout.fillWidth: true
                                color: textSilver
                                visible: fileNamingCombo.currentText === "custom"
                                background: Rectangle { color: slateBg; border.color: borderSlate; radius: 4 }
                                onTextChanged: root.saveSetting("custom_file_naming_template", text)
                            }
                        }
                    }
                }
            }

            // SECTION 4: Build Pack Config
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height + 20
                color: cardSlateBg
                border.color: borderSlate
                border.width: 1
                radius: 10

                ColumnLayout {
                    width: parent.width - 24
                    anchors.centerIn: parent
                    spacing: 12

                    Text {
                        text: root.getTxt("sec_build_pack")
                        color: metallicGold
                        font.bold: true
                        font.pixelSize: 14
                    }

                    GridLayout {
                        columns: 2
                        columnSpacing: 15
                        rowSpacing: 8
                        Layout.fillWidth: true

                        Text { text: root.getTxt("scan_mode_lbl"); color: textSilver; font.pixelSize: 11 }
                        ComboBox {
                            id: scanModeCombo
                            model: ["active_project", "code_folder", "custom_path"]
                            Layout.fillWidth: true
                            onActivated: root.saveSetting("build_pack_scan_mode", currentText)
                        }

                        Text { text: root.getTxt("export_format_lbl"); color: textSilver; font.pixelSize: 11 }
                        ComboBox {
                            id: exportFormatCombo
                            model: ["PLAIN", "JSON", "MARKDOWN"]
                            Layout.fillWidth: true
                            onActivated: root.saveSetting("build_pack_export_format", currentText)
                        }

                        Text { text: root.getTxt("wrapping_lbl"); color: textSilver; font.pixelSize: 11 }
                        ComboBox {
                            id: wrappingStyleCombo
                            model: ["bundled", "smart", "raw"]
                            Layout.fillWidth: true
                            onActivated: root.saveSetting("build_pack_wrapping_style", currentText)
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 20

                        RowLayout {
                            spacing: 8
                            Text { text: root.getTxt("include_non_code_lbl"); color: textSilver; font.pixelSize: 11 }
                            Switch {
                                id: includeNonCodeSwitch
                                onCheckedChanged: root.saveSetting("build_pack_include_non_code", checked.toString())
                            }
                        }

                        RowLayout {
                            spacing: 8
                            Text { text: root.getTxt("include_subdirs_lbl"); color: textSilver; font.pixelSize: 11 }
                            Switch {
                                id: includeSubdirsSwitch
                                onCheckedChanged: root.saveSetting("build_pack_include_subdirs", checked.toString())
                            }
                        }

                        RowLayout {
                            spacing: 8
                            Text { text: root.getTxt("md_to_html_lbl"); color: textSilver; font.pixelSize: 11 }
                            Switch {
                                id: mdToHtmlSwitch
                                onCheckedChanged: root.saveSetting("build_pack_markdown_to_html", checked.toString())
                            }
                        }
                    }
                }
            }

            // SECTION 5: Smart Capture
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height + 20
                color: cardSlateBg
                border.color: borderSlate
                border.width: 1
                radius: 10

                ColumnLayout {
                    width: parent.width - 24
                    anchors.centerIn: parent
                    spacing: 12

                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            text: root.getTxt("sec_smart_capture")
                            color: metallicGold
                            font.bold: true
                            font.pixelSize: 14
                            Layout.fillWidth: true
                        }
                        Switch {
                            id: scEnabledSwitch
                            onCheckedChanged: root.saveSetting("smart_capture_enabled", checked.toString())
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        visible: scEnabledSwitch.checked

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            RowLayout {
                                spacing: 8
                                Text { text: root.getTxt("sc_save_all_lbl"); color: textSilver; font.pixelSize: 11 }
                                Switch {
                                    id: scSaveAllSwitch
                                    onCheckedChanged: root.saveSetting("smart_capture_save_all", checked.toString())
                                }
                            }

                            RowLayout {
                                spacing: 8
                                Text { text: root.getTxt("sc_ignore_short_lbl"); color: textSilver; font.pixelSize: 11 }
                                Switch {
                                    id: scIgnoreShortSwitch
                                    onCheckedChanged: root.saveSetting("smart_capture_ignore_short", checked.toString())
                                }
                            }

                            RowLayout {
                                spacing: 8
                                Text { text: root.getTxt("sc_apply_all_themes_lbl"); color: textSilver; font.pixelSize: 11 }
                                Switch {
                                    id: scApplyAllSwitch
                                    onCheckedChanged: root.saveSetting("smart_capture_apply_all_themes", checked.toString())
                                }
                            }

                            RowLayout {
                                spacing: 8
                                Text { text: root.getTxt("sc_auto_import_lbl"); color: textSilver; font.pixelSize: 11 }
                                Switch {
                                    id: scAutoImportSwitch
                                    onCheckedChanged: root.saveSetting("smart_capture_auto_import", checked.toString())
                                }
                            }
                        }

                        GridLayout {
                            columns: 2
                            columnSpacing: 15
                            rowSpacing: 8
                            Layout.fillWidth: true

                            Text { text: root.getTxt("sc_default_theme_lbl"); color: textSilver; font.pixelSize: 11 }
                            ComboBox {
                                id: scDefaultThemeCombo
                                model: ["dark", "light", "academic", "oasis", "space"]
                                Layout.fillWidth: true
                                onActivated: root.saveSetting("smart_capture_default_theme", currentText)
                            }
                        }

                        Text { text: root.getTxt("sc_css_lbl"); color: textSilver; font.pixelSize: 11 }
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 120
                            color: slateBg
                            border.color: borderSlate
                            radius: 6

                            ScrollView {
                                anchors.fill: parent
                                anchors.margins: 6
                                TextArea {
                                    id: scCustomCssEdit
                                    color: textSilver
                                    font.family: "Courier"
                                    font.pixelSize: 11
                                    wrapMode: Text.Wrap
                                    onTextChanged: root.saveSetting("smart_capture_custom_css", text)
                                }
                            }
                        }
                    }
                }
            }

            // Secure Gemini Credentials
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 75
                color: cardSlateBg
                border.color: borderSlate
                border.width: 1
                radius: 10

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 12

                    Text {
                        text: root.getTxt("api_key_lbl")
                        color: textSilver
                        font.bold: true
                        font.pixelSize: 11
                    }

                    TextField {
                        id: geminiKeyEdit
                        passwordCharacter: "*"
                        echoMode: TextInput.Password
                        placeholderText: "Enter secure Gemini API key..."
                        color: textSilver
                        Layout.fillWidth: true
                        background: Rectangle {
                            color: slateBg; border.color: borderSlate; radius: 4
                        }
                    }

                    Button {
                        text: root.getTxt("btn_save_key")
                        onClicked: {
                            backend.set_gemini_api_key(geminiKeyEdit.text.trim())
                        }
                    }
                }
            }

            // Telemetry & Stats Box
            RowLayout {
                spacing: 15
                Layout.fillWidth: true
                Layout.preferredHeight: 180

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: cardSlateBg
                    border.color: borderSlate
                    radius: 10

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 12
                        Text {
                            text: backend.appLanguage === "ar" ? "📊 مؤشرات وإحصائيات المنصة (SQLite Telemetry):" : "📊 SQLite Database Diagnostics:"
                            color: metallicGold
                            font.bold: true
                            font.pixelSize: 12
                        }

                        Canvas {
                            id: settingsCanvasChart
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.clearRect(0, 0, width, height);

                                var countLogs = logsModel.count;
                                var countCaptures = capturesModel.count;
                                var countStyles = stylesModel.count;

                                var barWidth = 40;
                                var maxVal = Math.max(countLogs, countCaptures, countStyles, 5);

                                // Logs
                                ctx.fillStyle = metallicGold;
                                var barH1 = (countLogs / maxVal) * (height - 40);
                                ctx.fillRect(40, height - barH1 - 20, barWidth, barH1);
                                ctx.fillStyle = textSilver;
                                ctx.fillText(backend.appLanguage === "ar" ? "السجلات" : "Logs", 40, height - 5);

                                // Captures
                                ctx.fillStyle = successGreen;
                                var barH2 = (countCaptures / maxVal) * (height - 40);
                                ctx.fillRect(120, height - barH2 - 20, barWidth, barH2);
                                ctx.fillStyle = textSilver;
                                ctx.fillText(backend.appLanguage === "ar" ? "الالتقاطات" : "Captures", 120, height - 5);

                                // Styles
                                ctx.fillStyle = warningOrange;
                                var barH3 = (countStyles / maxVal) * (height - 40);
                                ctx.fillRect(200, height - barH3 - 20, barWidth, barH3);
                                ctx.fillStyle = textSilver;
                                ctx.fillText(backend.appLanguage === "ar" ? "التصاميم" : "Styles", 200, height - 5);
                            }
                        }
                    }
                }
            }

            // SECTION 6: About the platform & Diagnostics
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height + 20
                color: cardSlateBg
                border.color: borderSlate
                border.width: 1
                radius: 10

                ColumnLayout {
                    width: parent.width - 24
                    anchors.centerIn: parent
                    spacing: 12

                    Text {
                        text: root.getTxt("sec_about")
                        color: metallicGold
                        font.bold: true
                        font.pixelSize: 14
                    }

                    Text {
                        text: root.getTxt("about_p1")
                        color: textSilver
                        font.pixelSize: 11
                        wrapMode: Text.Wrap
                        Layout.fillWidth: true
                    }

                    Text {
                        text: root.getTxt("about_p2")
                        color: textGray
                        font.pixelSize: 10
                        wrapMode: Text.Wrap
                        Layout.fillWidth: true
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        Button {
                            text: root.getTxt("btn_help_center")
                            onClicked: {
                                mainStack.currentIndex = 7; // TAB 7 is Help Center
                            }
                        }

                        Button {
                            text: root.getTxt("btn_source_exporter")
                            onClicked: {
                                mainStack.currentIndex = 14; // TAB 14 is Source Export Screen
                            }
                        }
                    }
                }
            }

            // Event Logs Listing
            RowLayout {
                Layout.fillWidth: true
                Text {
                    text: root.getTxt("sqlite_log_lbl")
                    color: metallicGold
                    font.bold: true
                }
                Spacer { Layout.fillWidth: true }
                Button {
                    text: root.getTxt("btn_clear_logs")
                    onClicked: {
                        backend.clear_logs();
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 180
                color: slateBg
                border.color: borderSlate
                radius: 8

                ScrollView {
                    anchors.fill: parent
                    ListView {
                        id: settingsLogsListView
                        model: logsModel
                        spacing: 6
                        delegate: Rectangle {
                            width: settingsLogsListView.width - 20
                            height: 40
                            color: model.type === "error" ? "#3B111A" : (model.type === "success" ? "#113B24" : cardSlateBg)
                            border.color: borderSlate
                            radius: 6
                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 12
                                anchors.rightMargin: 12
                                Text { text: model.message; color: textSilver; font.pixelSize: 11; Layout.fillWidth: true }
                                Text { text: model.created_at; color: textGray; font.pixelSize: 9 }
                            }
                        }
                    }
                }
            }
        }
    }

    // Dialog folders setup
    FolderDialog {
        id: baseFolderDialog
        title: "اختر مجلد العمل الافتراضي النشط"
        onAccepted: {
            backend.baseDir = selectedFolder.toString();
            baseDirInput.text = backend.baseDir;
        }
    }
}
