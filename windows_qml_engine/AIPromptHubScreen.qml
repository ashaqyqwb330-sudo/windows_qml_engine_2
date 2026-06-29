import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "transparent"

    // Modular Translation Dictionary
    function getTxt(key) {
        var translations = {
            "title": { "ar": "📚 مستودع التوجيهات الفائقة (AIPromptHub)", "en": "📚 Master Instructions Guide & Prompt Hub" },
            "desc": { "ar": "الدليل الشامل والتفاعلي لتصميم وتوجيه الأكواد والمهام الذكية للمساعدات البرمجية لتنفيذها آلياً بنسبة 100%.", "en": "The complete, interactive handbook for designing, directing, and executing smart code and terminal tasks automatically." },
            
            // Tab Titles
            "tab_quick": { "ar": "🚀 البدء السريع", "en": "🚀 Quick Start" },
            "tab_builder": { "ar": "📝 منشئ الأكواد (@builder)", "en": "📝 Code Builder (@builder)" },
            "tab_executor": { "ar": "🖥️ منفذ الأوامر (@executor)", "en": "🖥️ Command Executor (@executor)" },
            "tab_treedoc": { "ar": "🌳 التقارير الشجرية (@treedoc)", "en": "🌳 TreeDoc (@treedoc)" },
            "tab_templates": { "ar": "📂 قوالب المشاريع", "en": "📂 Project Templates" },
            "tab_prompts": { "ar": "🤖 تلقين المساعد الذكي", "en": "🤖 AI System Prompts" },

            // General & Interactive items
            "btn_copy": { "ar": "نسخ القالب 📋", "en": "Copy Template 📋" },
            "btn_copy_prompt": { "ar": "نسخ نص التلقين 📋", "en": "Copy System Prompt 📋" },
            "toast_copy": { "ar": "تم النسخ بنجاح إلى الحافظة!", "en": "Copied successfully to clipboard!" },
            "pro_tip": { "ar": "💡 نصيحة احترافية للمطورين:", "en": "💡 Pro Developer Tip:" },

            // Tab 1: Quick Start
            "qs_title": { "ar": "دليل البدء السريع للمنصة الذهبية", "en": "Golden Platform Quick Start Guide" },
            "qs_step1_title": { "ar": "1. تلقين المساعد الذكي", "en": "1. Prompt Your AI" },
            "qs_step1_desc": { "ar": "قم بنسخ نص التلقين العام (من تبويبة التلقين) وإرساله إلى ChatGPT أو Gemini أو DeepSeek ليفهم القواعد.", "en": "Copy the system prompt from the AI System Prompts tab and feed it to ChatGPT, Gemini, or DeepSeek so it understands the syntax rules." },
            "qs_step2_title": { "ar": "2. اطلب بناء التطبيق", "en": "2. Request Your App" },
            "qs_step2_desc": { "ar": "اطلب من الذكاء الاصطناعي بناء ميزة معينة، وسيولد لك الأكواد مغلفة داخل وسم @builder تلقائياً.", "en": "Request the AI to build or edit any feature. It will output the modified source code packaged neatly inside @builder blocks." },
            "qs_step3_title": { "ar": "3. نسخ النص وتشغيل الأتمتة", "en": "3. Copy Text & Automate" },
            "qs_step3_desc": { "ar": "بمجرد نسخ النص الكامل للرد، سيقوم مراقب الحافظة الذكي بامتصاص الملفات وتطبيقها على مسار مشروعك في الخلفية!", "en": "Simply copy the entire AI response text. The background clipboard monitor will capture and write the files directly into your workspace!" },
            "qs_note": { "ar": "تأكد من تفعيل مراقب الحافظة والفقاعة العائمة في الإعدادات لرؤية الإشعارات والعمليات مباشرة على شاشتك.", "en": "Make sure Clipboard Monitor and Floating Overlay are enabled in your Preferences to see immediate progress notifications on your screen." },

            // Tab 2: Builder
            "b_desc": { "ar": "يُستخدم توجيه @builder لإنشاء وتحديث الملفات البرمجية. يقوم المحرك بمسح النص المنسوخ، واستخراج كل جزء وتخزينه في مساره الصحيح تلقائياً.", "en": "The @builder directive writes files directly to disk. The engine parses target filenames, makes backups of existing files, and extracts code contents safely." },
            "b_format_title": { "ar": "الصيغة العامة المدعومة:", "en": "General Supported Syntax:" },
            "b_syntax_info": { "ar": "يمكنك استخدام تعليقات بايثون (#) أو جافا سكريبت/سي (//) أو HTML (<!--) كبادئات لخط البداية والنهاية.", "en": "You can use C-style comments (//), Python/Shell comments (#), or HTML comments (<!--) as prefixes for start and end tags." },
            "b_level_beg": { "ar": "🟢 مستوى مبتدئ: ملف نصي بسيط", "en": "🟢 Beginner Level: Plain Text File" },
            "b_level_med": { "ar": "🟡 مستوى متوسط: صفحة ويب HTML", "en": "🟡 Intermediate Level: Web Layout" },
            "b_level_adv": { "ar": "🔴 مستوى متقدم: كود بايثون لمعالجة البيانات", "en": "🔴 Advanced Level: Python Data Processing" },
            "b_errors_title": { "ar": "⚠️ أخطاء شائعة وكيفية تجنبها:", "en": "⚠️ Common Errors & Troubleshooting:" },
            "b_err_1": { "ar": "❌ نسيان غلق التوجيه بالوسم @builder:end - سيؤدي هذا لتجاهل الملف أو دمج بقية النصوص داخله.", "en": "❌ Forgetting to close with @builder:end - results in the entire remaining response text being appended inside the file." },
            "b_err_2": { "ar": "❌ كتابة مسارات مطلقة مثل C:/project - استخدم دائماً المسارات النسبية لتجنب الفشل البرمجي على الأجهزة الأخرى.", "en": "❌ Using absolute physical paths like C:/workspace - Always use relative paths relative to your active project." },
            "b_err_3": { "ar": "❌ تكرار كتابة نفس الملف في نفس الحزمة - المحرك سيحفظ النسخة الأخيرة فقط ويمسح التعديل الأول.", "en": "❌ Duplicating the same file path inside one package - Only the last occurrence will be saved." },

            // Tab 3: Executor
            "e_desc": { "ar": "تسمح توجيهات @executor بتشغيل أوامر آمنة وإدارة الملفات في خلفية نظام التشغيل مع إظهار المخرجات بدقة فائقة وبشكل معزول تماماً لحماية جهازك.", "en": "The @executor directives enable secure background shell executions, terminal actions, and local file operations, isolating outputs for high efficiency." },
            "e_format_title": { "ar": "الصيغة المدعومة:", "en": "Supported Command Style:" },
            "e_plan_title": { "ar": "خطط وتدابير الأرشفة والتنظيم:", "en": "Organizational Actions & Planning Templates:" },
            "e_plan_1": { "ar": "فرز وتصنيف كافة الملفات حسب الصيغة والتاريخ:", "en": "Sort and classify all files by format and date:" },
            "e_plan_2": { "ar": "أرشفة الملفات وإزالة المجلدات المكررة الآمنة:", "en": "Archive files and clean up redundant duplicate code segments:" },

            // Tab 4: TreeDoc
            "t_desc": { "ar": "يُستخدم توجيه @treedoc لتوليد وعرض خرائط شجرية تفاعلية للمجلدات، مما يوفر للذكاء الاصطناعي لمحة شاملة عن هيكل ومحتويات كودك بدون إرسال كامل الملفات.", "en": "The @treedoc directive builds rich, hierarchical directory blueprints and maps, ideal for providing LLMs with comprehensive, high-level context of your project structure." },
            "t_format_title": { "ar": "صيغ ومؤشرات التوليد الشجري:", "en": "TreeDoc Generation Configurations:" },
            "t_format_info": { "ar": "يمكن توليد التقارير الشجرية التفاعلية بثلاثة تنسيقات رئيسية: نصي بسيط (TXT)، صفحة ويب منسقة (HTML)، أو كائن بيانات مرن (JSON).", "en": "You can request visual tree layouts in three styles: Plain Text (TXT), Beautified Interactive Web page (HTML), or raw JSON representation." },
            "t_example_title": { "ar": "نموذج لتقرير شجري مولد تلقائياً:", "en": "Visual Map Sample Generated by Engine:" },

            // Tab 5: Templates
            "tmp_desc": { "ar": "تتيح ميزة قوالب المشاريع للمطورين مشاركة وإنشاء هياكل ملفات كاملة لسيناريوهات محددة (مثل تطبيق Flutter، مشروع Python، موقع React) بلمسة واحدة.", "en": "The project templates feature lets you share and spin up entire skeletal file and directory structures for tailored environments (Flutter, Python, React, Kotlin) instantly using a structured JSON declaration." },
            "tmp_format_title": { "ar": "بنية القالب القياسية (JSON):", "en": "Standard Project Template Schema (JSON):" },
            "tmp_fields_title": { "ar": "شرح حقول القالب الهامة:", "en": "Key Structural JSON Parameters:" },
            "tmp_field_folders": { "ar": "• folders: قائمة المجلدات الفرعية المطلوب إنشاؤها تلقائياً عند بدء المشروع.", "en": "• folders: Array of directories and subfolders to instantly scaffold on disk." },
            "tmp_field_files": { "ar": "• fileTypes: التنسيقات والملفات البرمجية الافتراضية مع الكود المبدئي لكل ملف.", "en": "• fileTypes: Default configurations and boilerplate templates associated with each file type extension." },
            "tmp_field_keywords": { "ar": "• keywords: الكلمات الدلالية لتنبيه المحرك والذكاء الاصطناعي للتحقق من سلامة الأكواد.", "en": "• keywords: Trigger words and criteria verified by the safety engine validator." },

            // Tab 6: System Prompts
            "sp_desc": { "ar": "قم بتلقين المساعد الذكي الخاص بك باستخدام نصوص التلقين التالية لضمان إنتاجه للأكواد والملفات بالصيغة الصحيحة المتوافقة تماماً مع محرك المنصة الذهبية.", "en": "Feed these carefully crafted developer system prompts directly to your preferred AI model to ensure 100% compliant outputs aligned with our extraction engine." },
            "sp_generic_title": { "ar": "🤖 نص التلقين العام (لجميع المساعدات الذكية)", "en": "🤖 Universal System Prompt (All LLMs)" },
            "sp_gemini_title": { "ar": "✨ نص التلقين المخصص لـ Gemini Pro API", "en": "✨ Optimized Prompt for Gemini Pro / AI Studio" },
            "sp_deepseek_title": { "ar": "🧠 نص التلقين المخصص لـ DeepSeek Coder", "en": "🧠 Specialized Prompt for DeepSeek Coder" }
        };
        var isAr = (backend.appLanguage === "ar");
        return translations[key] ? (isAr ? translations[key]["ar"] : translations[key]["en"]) : "";
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        // Header Card
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 85
            color: cardSlateBg
            border.color: borderSlate
            radius: 10

            RowLayout {
                anchors.fill: parent
                anchors.margins: 14
                spacing: 12

                Text {
                    text: "📚"
                    font.pixelSize: 36
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Text {
                        text: root.getTxt("title")
                        color: metallicGold
                        font.bold: true
                        font.pixelSize: 16
                    }
                    Text {
                        text: root.getTxt("desc")
                        color: textSilver
                        font.pixelSize: 11
                        wrapMode: Text.Wrap
                        Layout.fillWidth: true
                    }
                }
            }
        }

        // Tab Bar for Navigation
        TabBar {
            id: hubTabBar
            Layout.fillWidth: true
            background: Rectangle {
                color: slateBg
                border.color: borderSlate
                radius: 6
            }

            TabButton {
                text: root.getTxt("tab_quick")
                contentItem: Text {
                    text: parent.text
                    color: parent.checked ? metallicGold : textSilver
                    font.bold: parent.checked
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: parent.checked ? cardSlateBg : "transparent"
                    border.color: parent.checked ? borderSlate : "transparent"
                    radius: 4
                }
            }

            TabButton {
                text: root.getTxt("tab_builder")
                contentItem: Text {
                    text: parent.text
                    color: parent.checked ? metallicGold : textSilver
                    font.bold: parent.checked
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: parent.checked ? cardSlateBg : "transparent"
                    border.color: parent.checked ? borderSlate : "transparent"
                    radius: 4
                }
            }

            TabButton {
                text: root.getTxt("tab_executor")
                contentItem: Text {
                    text: parent.text
                    color: parent.checked ? metallicGold : textSilver
                    font.bold: parent.checked
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: parent.checked ? cardSlateBg : "transparent"
                    border.color: parent.checked ? borderSlate : "transparent"
                    radius: 4
                }
            }

            TabButton {
                text: root.getTxt("tab_treedoc")
                contentItem: Text {
                    text: parent.text
                    color: parent.checked ? metallicGold : textSilver
                    font.bold: parent.checked
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: parent.checked ? cardSlateBg : "transparent"
                    border.color: parent.checked ? borderSlate : "transparent"
                    radius: 4
                }
            }

            TabButton {
                text: root.getTxt("tab_templates")
                contentItem: Text {
                    text: parent.text
                    color: parent.checked ? metallicGold : textSilver
                    font.bold: parent.checked
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: parent.checked ? cardSlateBg : "transparent"
                    border.color: parent.checked ? borderSlate : "transparent"
                    radius: 4
                }
            }

            TabButton {
                text: root.getTxt("tab_prompts")
                contentItem: Text {
                    text: parent.text
                    color: parent.checked ? metallicGold : textSilver
                    font.bold: parent.checked
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: parent.checked ? cardSlateBg : "transparent"
                    border.color: parent.checked ? borderSlate : "transparent"
                    radius: 4
                }
            }
        }

        // Tab Content Stack
        StackLayout {
            id: hubStack
            currentIndex: hubTabBar.currentIndex
            Layout.fillWidth: true
            Layout.fillHeight: true

            // TAB 1: Quick Start
            ScrollView {
                clip: true
                ColumnLayout {
                    width: hubStack.width - 20
                    spacing: 12

                    Text {
                        text: root.getTxt("qs_title")
                        color: metallicGold
                        font.bold: true
                        font.pixelSize: 14
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height + 20
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8

                        ColumnLayout {
                            width: parent.width - 24
                            anchors.centerIn: parent
                            spacing: 14

                            // Step 1
                            RowLayout {
                                spacing: 10
                                Layout.fillWidth: true
                                Text { text: "1️⃣"; font.pixelSize: 22 }
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    Text { text: root.getTxt("qs_step1_title"); color: metallicGold; font.bold: true; font.pixelSize: 12 }
                                    Text { text: root.getTxt("qs_step1_desc"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }
                                }
                            }

                            // Step 2
                            RowLayout {
                                spacing: 10
                                Layout.fillWidth: true
                                Text { text: "2️⃣"; font.pixelSize: 22 }
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    Text { text: root.getTxt("qs_step2_title"); color: metallicGold; font.bold: true; font.pixelSize: 12 }
                                    Text { text: root.getTxt("qs_step2_desc"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }
                                }
                            }

                            // Step 3
                            RowLayout {
                                spacing: 10
                                Layout.fillWidth: true
                                Text { text: "3️⃣"; font.pixelSize: 22 }
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    Text { text: root.getTxt("qs_step3_title"); color: metallicGold; font.bold: true; font.pixelSize: 12 }
                                    Text { text: root.getTxt("qs_step3_desc"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }
                                }
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height + 16
                        color: "#1e1b4b"
                        border.color: "#4338ca"
                        radius: 8
                        RowLayout {
                            width: parent.width - 20
                            anchors.centerIn: parent
                            spacing: 10
                            Text { text: "💡"; font.pixelSize: 18 }
                            Text {
                                text: root.getTxt("qs_note")
                                color: "#c7d2fe"
                                font.pixelSize: 11
                                wrapMode: Text.Wrap
                                Layout.fillWidth: true
                            }
                        }
                    }
                }
            }

            // TAB 2: Code Builder (@builder)
            ScrollView {
                clip: true
                ColumnLayout {
                    width: hubStack.width - 20
                    spacing: 12

                    Text {
                        text: root.getTxt("b_desc")
                        color: textSilver
                        font.pixelSize: 12
                        wrapMode: Text.Wrap
                        Layout.fillWidth: true
                    }

                    Text {
                        text: root.getTxt("b_format_title")
                        color: metallicGold
                        font.bold: true
                        font.pixelSize: 12
                    }

                    Text {
                        text: root.getTxt("b_syntax_info")
                        color: textGray
                        font.pixelSize: 11
                        wrapMode: Text.Wrap
                        Layout.fillWidth: true
                    }

                    // Level 1: Beginner
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height + 15
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        ColumnLayout {
                            width: parent.width - 24
                            anchors.centerIn: parent
                            spacing: 8
                            RowLayout {
                                Layout.fillWidth: true
                                Text { text: root.getTxt("b_level_beg"); color: metallicGold; font.bold: true; font.pixelSize: 12 }
                                Spacer { Layout.fillWidth: true }
                                Button {
                                    text: root.getTxt("btn_copy")
                                    onClicked: {
                                        var code = "// @builder:file notes.txt\nأهلاً بك في المنصة الذهبية للتحكم الآلي بالملفات.\nهذا ملف تجريبي بسيط.\n// @builder:end";
                                        backend.set_setting("clipboard_monitor", "false"); // temp bypass monitor to copy safely
                                        backend.execute_command_advanced("clipboard " + code, "", false);
                                        backend.set_setting("clipboard_monitor", "true");
                                        backend.notificationSent(backend.appLanguage === "ar" ? "نسخ" : "Copied", root.getTxt("toast_copy"), "success");
                                    }
                                }
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 65
                                color: slateBg
                                radius: 4
                                ScrollView {
                                    anchors.fill: parent
                                    anchors.margins: 6
                                    Text {
                                        text: "// @builder:file notes.txt\nأهلاً بك في المنصة الذهبية للتحكم الآلي بالملفات.\nهذا ملف تجريبي بسيط.\n// @builder:end"
                                        color: warningOrange
                                        font.family: "Courier"
                                        font.pixelSize: 11
                                    }
                                }
                            }
                        }
                    }

                    // Level 2: Medium
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height + 15
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        ColumnLayout {
                            width: parent.width - 24
                            anchors.centerIn: parent
                            spacing: 8
                            RowLayout {
                                Layout.fillWidth: true
                                Text { text: root.getTxt("b_level_med"); color: metallicGold; font.bold: true; font.pixelSize: 12 }
                                Spacer { Layout.fillWidth: true }
                                Button {
                                    text: root.getTxt("btn_copy")
                                    onClicked: {
                                        var code = "<!-- @builder:file index.html -->\n<!DOCTYPE html>\n<html>\n<head><title>Golden Platform</title></head>\n<body>\n  <h1>Welcome to Golden Pro</h1>\n</body>\n</html>\n<!-- @builder:end -->";
                                        backend.set_setting("clipboard_monitor", "false");
                                        backend.execute_command_advanced("clipboard " + code, "", false);
                                        backend.set_setting("clipboard_monitor", "true");
                                        backend.notificationSent(backend.appLanguage === "ar" ? "نسخ" : "Copied", root.getTxt("toast_copy"), "success");
                                    }
                                }
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 110
                                color: slateBg
                                radius: 4
                                ScrollView {
                                    anchors.fill: parent
                                    anchors.margins: 6
                                    Text {
                                        text: "<!-- @builder:file index.html -->\n<!DOCTYPE html>\n<html>\n<head><title>Golden Platform</title></head>\n<body>\n  <h1>Welcome to Golden Pro</h1>\n</body>\n</html>\n<!-- @builder:end -->"
                                        color: successGreen
                                        font.family: "Courier"
                                        font.pixelSize: 11
                                    }
                                }
                            }
                        }
                    }

                    // Level 3: Advanced
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height + 15
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        ColumnLayout {
                            width: parent.width - 24
                            anchors.centerIn: parent
                            spacing: 8
                            RowLayout {
                                Layout.fillWidth: true
                                Text { text: root.getTxt("b_level_adv"); color: metallicGold; font.bold: true; font.pixelSize: 12 }
                                Spacer { Layout.fillWidth: true }
                                Button {
                                    text: root.getTxt("btn_copy")
                                    onClicked: {
                                        var code = "# @builder:file app.py\nimport sys\ndef process_stats():\n    print(\"📊 Analysis initiated successfully.\")\nif __name__ == \"__main__\":\n    process_stats()\n# @builder:end";
                                        backend.set_setting("clipboard_monitor", "false");
                                        backend.execute_command_advanced("clipboard " + code, "", false);
                                        backend.set_setting("clipboard_monitor", "true");
                                        backend.notificationSent(backend.appLanguage === "ar" ? "نسخ" : "Copied", root.getTxt("toast_copy"), "success");
                                    }
                                }
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 95
                                color: slateBg
                                radius: 4
                                ScrollView {
                                    anchors.fill: parent
                                    anchors.margins: 6
                                    Text {
                                        text: "# @builder:file app.py\nimport sys\ndef process_stats():\n    print(\"📊 Analysis initiated successfully.\")\nif __name__ == \"__main__\":\n    process_stats()\n# @builder:end"
                                        color: metallicGold
                                        font.family: "Courier"
                                        font.pixelSize: 11
                                    }
                                }
                            }
                        }
                    }

                    // Troubleshooting Collapsible Cards
                    Text {
                        text: root.getTxt("b_errors_title")
                        color: errorRed
                        font.bold: true
                        font.pixelSize: 12
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height + 16
                        color: cardSlateBg
                        border.color: "#3b0712"
                        radius: 8
                        ColumnLayout {
                            width: parent.width - 24
                            anchors.centerIn: parent
                            spacing: 8
                            Text { text: root.getTxt("b_err_1"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }
                            Text { text: root.getTxt("b_err_2"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }
                            Text { text: root.getTxt("b_err_3"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }
                        }
                    }
                }
            }

            // TAB 3: Executor (@executor)
            ScrollView {
                clip: true
                ColumnLayout {
                    width: hubStack.width - 20
                    spacing: 12

                    Text {
                        text: root.getTxt("e_desc")
                        color: textSilver
                        font.pixelSize: 12
                        wrapMode: Text.Wrap
                        Layout.fillWidth: true
                    }

                    Text {
                        text: root.getTxt("e_format_title")
                        color: metallicGold
                        font.bold: true
                        font.pixelSize: 12
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 55
                        color: slateBg
                        border.color: borderSlate
                        radius: 6
                        Text {
                            anchors.centerIn: parent
                            text: "// @executor: python test.py\n# @executor: node app.js"
                            color: warningOrange
                            font.family: "Courier"
                            font.bold: true
                            font.pixelSize: 12
                        }
                    }

                    Text {
                        text: root.getTxt("e_plan_title")
                        color: metallicGold
                        font.bold: true
                        font.pixelSize: 12
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height + 15
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        ColumnLayout {
                            width: parent.width - 24
                            anchors.centerIn: parent
                            spacing: 8
                            RowLayout {
                                Layout.fillWidth: true
                                Text { text: root.getTxt("e_plan_1"); color: metallicGold; font.bold: true; font.pixelSize: 11 }
                                Spacer { Layout.fillWidth: true }
                                Button {
                                    text: root.getTxt("btn_copy")
                                    onClicked: {
                                        var code = "// @executor: scan\n// @executor: duplicates\n// @executor: report";
                                        backend.set_setting("clipboard_monitor", "false");
                                        backend.execute_command_advanced("clipboard " + code, "", false);
                                        backend.set_setting("clipboard_monitor", "true");
                                        backend.notificationSent(backend.appLanguage === "ar" ? "نسخ" : "Copied", root.getTxt("toast_copy"), "success");
                                    }
                                }
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 65
                                color: slateBg
                                radius: 4
                                Text {
                                    anchors.centerIn: parent
                                    text: "// @executor: scan\n// @executor: duplicates\n// @executor: report"
                                    color: successGreen
                                    font.family: "Courier"
                                    font.pixelSize: 11
                                }
                            }
                        }
                    }
                }
            }

            // TAB 4: TreeDoc (@treedoc)
            ScrollView {
                clip: true
                ColumnLayout {
                    width: hubStack.width - 20
                    spacing: 12

                    Text {
                        text: root.getTxt("t_desc")
                        color: textSilver
                        font.pixelSize: 12
                        wrapMode: Text.Wrap
                        Layout.fillWidth: true
                    }

                    Text {
                        text: root.getTxt("t_format_title")
                        color: metallicGold
                        font.bold: true
                        font.pixelSize: 12
                    }

                    Text {
                        text: root.getTxt("t_format_info")
                        color: textGray
                        font.pixelSize: 11
                        wrapMode: Text.Wrap
                        Layout.fillWidth: true
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 60
                        color: slateBg
                        border.color: borderSlate
                        radius: 6
                        Text {
                            anchors.centerIn: parent
                            text: "// @treedoc: txt | html | json"
                            color: warningOrange
                            font.family: "Courier"
                            font.bold: true
                            font.pixelSize: 13
                        }
                    }

                    Text {
                        text: root.getTxt("t_example_title")
                        color: metallicGold
                        font.bold: true
                        font.pixelSize: 12
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 140
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        ScrollView {
                            anchors.fill: parent
                            anchors.margins: 12
                            Text {
                                text: "📁 Project_Root\n ├── 📂 app\n │    ├── 📄 build.gradle.kts\n │    └── 📂 src\n │         └── 📂 main\n │              ├── 📄 AndroidManifest.xml\n │              └── 📂 java\n └── 📄 settings.gradle.kts"
                                color: textSilver
                                font.family: "Courier"
                                font.pixelSize: 11
                            }
                        }
                    }
                }
            }

            // TAB 5: Templates
            ScrollView {
                clip: true
                ColumnLayout {
                    width: hubStack.width - 20
                    spacing: 12

                    Text {
                        text: root.getTxt("tmp_desc")
                        color: textSilver
                        font.pixelSize: 12
                        wrapMode: Text.Wrap
                        Layout.fillWidth: true
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            text: root.getTxt("tmp_format_title")
                            color: metallicGold
                            font.bold: true
                            font.pixelSize: 12
                        }
                        Spacer { Layout.fillWidth: true }
                        Button {
                            text: root.getTxt("btn_copy")
                            onClicked: {
                                var code = '{\n  "name": "Python Fast API",\n  "folders": ["app", "tests", "config"],\n  "fileTypes": {\n    "main.py": "print(\'Hello From Golden Platform!\')"\n  }\n}';
                                backend.set_setting("clipboard_monitor", "false");
                                backend.execute_command_advanced("clipboard " + code, "", false);
                                backend.set_setting("clipboard_monitor", "true");
                                backend.notificationSent(backend.appLanguage === "ar" ? "نسخ" : "Copied", root.getTxt("toast_copy"), "success");
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 140
                        color: slateBg
                        border.color: borderSlate
                        radius: 8
                        ScrollView {
                            anchors.fill: parent
                            anchors.margins: 10
                            Text {
                                text: '{\n  "name": "Python Fast API",\n  "folders": ["app", "tests", "config"],\n  "fileTypes": {\n    "main.py": "print(\'Hello From Golden Platform!\')"\n  }\n}'
                                color: warningOrange
                                font.family: "Courier"
                                font.pixelSize: 11
                            }
                        }
                    }

                    Text {
                        text: root.getTxt("tmp_fields_title")
                        color: metallicGold
                        font.bold: true
                        font.pixelSize: 12
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height + 16
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        ColumnLayout {
                            width: parent.width - 24
                            anchors.centerIn: parent
                            spacing: 8
                            Text { text: root.getTxt("tmp_field_folders"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }
                            Text { text: root.getTxt("tmp_field_files"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }
                            Text { text: root.getTxt("tmp_field_keywords"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }
                        }
                    }
                }
            }

            // TAB 6: AI System Prompts
            ScrollView {
                clip: true
                ColumnLayout {
                    width: hubStack.width - 20
                    spacing: 12

                    Text {
                        text: root.getTxt("sp_desc")
                        color: textSilver
                        font.pixelSize: 12
                        wrapMode: Text.Wrap
                        Layout.fillWidth: true
                    }

                    // Generic Prompt Card
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height + 15
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        ColumnLayout {
                            width: parent.width - 24
                            anchors.centerIn: parent
                            spacing: 8
                            RowLayout {
                                Layout.fillWidth: true
                                Text { text: root.getTxt("sp_generic_title"); color: metallicGold; font.bold: true; font.pixelSize: 12 }
                                Spacer { Layout.fillWidth: true }
                                Button {
                                    text: root.getTxt("btn_copy_prompt")
                                    onClicked: {
                                        var code = "You are a professional assistant for the Golden Platform system. When sending files, always enclose them in @builder:file <path> and @builder:end blocks. For executing commands, use @executor: <command>. Keep path names relative.";
                                        backend.set_setting("clipboard_monitor", "false");
                                        backend.execute_command_advanced("clipboard " + code, "", false);
                                        backend.set_setting("clipboard_monitor", "true");
                                        backend.notificationSent(backend.appLanguage === "ar" ? "نسخ" : "Copied", root.getTxt("toast_copy"), "success");
                                    }
                                }
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 75
                                color: slateBg
                                radius: 4
                                ScrollView {
                                    anchors.fill: parent
                                    anchors.margins: 6
                                    Text {
                                        text: "You are a professional assistant for the Golden Platform system. When sending files, always enclose them in @builder:file <path> and @builder:end blocks. For executing commands, use @executor: <command>. Keep path names relative."
                                        color: textSilver
                                        font.pixelSize: 11
                                        wrapMode: Text.Wrap
                                        Layout.fillWidth: true
                                    }
                                }
                            }
                        }
                    }

                    // Gemini Prompt Card
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height + 15
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        ColumnLayout {
                            width: parent.width - 24
                            anchors.centerIn: parent
                            spacing: 8
                            RowLayout {
                                Layout.fillWidth: true
                                Text { text: root.getTxt("sp_gemini_title"); color: metallicGold; font.bold: true; font.pixelSize: 12 }
                                Spacer { Layout.fillWidth: true }
                                Button {
                                    text: root.getTxt("btn_copy_prompt")
                                    onClicked: {
                                        var code = "You are Gemini Pro acting as a backend coder for the Golden Platform. Always provide complete files. Use exact @builder:file <path> blocks and never truncate code inside. For automated testing, suggest @executor: test or @executor: run.";
                                        backend.set_setting("clipboard_monitor", "false");
                                        backend.execute_command_advanced("clipboard " + code, "", false);
                                        backend.set_setting("clipboard_monitor", "true");
                                        backend.notificationSent(backend.appLanguage === "ar" ? "نسخ" : "Copied", root.getTxt("toast_copy"), "success");
                                    }
                                }
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 75
                                color: slateBg
                                radius: 4
                                ScrollView {
                                    anchors.fill: parent
                                    anchors.margins: 6
                                    Text {
                                        text: "You are Gemini Pro acting as a backend coder for the Golden Platform. Always provide complete files. Use exact @builder:file <path> blocks and never truncate code inside. For automated testing, suggest @executor: test or @executor: run."
                                        color: textSilver
                                        font.pixelSize: 11
                                        wrapMode: Text.Wrap
                                        Layout.fillWidth: true
                                    }
                                }
                            }
                        }
                    }

                    // DeepSeek Prompt Card
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height + 15
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        ColumnLayout {
                            width: parent.width - 24
                            anchors.centerIn: parent
                            spacing: 8
                            RowLayout {
                                Layout.fillWidth: true
                                Text { text: root.getTxt("sp_deepseek_title"); color: metallicGold; font.bold: true; font.pixelSize: 12 }
                                Spacer { Layout.fillWidth: true }
                                Button {
                                    text: root.getTxt("btn_copy_prompt")
                                    onClicked: {
                                        var code = "For DeepSeek Coder: Enclose modified parts or fully updated files directly inside comments using // @builder:file <path> and // @builder:end. Write secure shell commands with @executor: <command> for direct automation.";
                                        backend.set_setting("clipboard_monitor", "false");
                                        backend.execute_command_advanced("clipboard " + code, "", false);
                                        backend.set_setting("clipboard_monitor", "true");
                                        backend.notificationSent(backend.appLanguage === "ar" ? "نسخ" : "Copied", root.getTxt("toast_copy"), "success");
                                    }
                                }
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 75
                                color: slateBg
                                radius: 4
                                ScrollView {
                                    anchors.fill: parent
                                    anchors.margins: 6
                                    Text {
                                        text: "For DeepSeek Coder: Enclose modified parts or fully updated files directly inside comments using // @builder:file <path> and // @builder:end. Write secure shell commands with @executor: <command> for direct automation."
                                        color: textSilver
                                        font.pixelSize: 11
                                        wrapMode: Text.Wrap
                                        Layout.fillWidth: true
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
