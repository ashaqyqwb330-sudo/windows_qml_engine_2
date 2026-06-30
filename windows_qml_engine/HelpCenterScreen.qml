import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "transparent"

    // Bilingual Dictionary (AR / EN)
    function getTxt(key) {
        var translations = {
            "title": { "ar": "📖 مركز المساعدة والدعم التفاعلي Pro", "en": "📖 Interactive Help & Learning Center Pro" },
            "desc": { "ar": "دليلك الكامل لفهم آليات الأتمتة، محاكاة سيناريوهات التشغيل، وتعلم كيفية قيادة المنصة الذهبية باحترافية.", "en": "Your complete guide to understanding automation flows, simulating engine states, and mastering the Golden Platform." },

            // Tabs
            "tab_glossary": { "ar": "📖 القاموس البرمجي", "en": "📖 Glossary" },
            "tab_faq": { "ar": "❓ الأسئلة الشائعة", "en": "❓ FAQ" },
            "tab_scenarios": { "ar": "🎬 سيناريوهات عملية", "en": "🎬 Practical Scenarios" },
            "tab_simulator": { "ar": "🎮 محاكي الأتمتة", "en": "🎮 Flow Simulator" },

            // Buttons & UI
            "btn_simulate": { "ar": "🎮 تشغيل المحاكاة التفاعلية", "en": "🎮 Start Flow Simulation" },
            "btn_copy_json": { "ar": "نسخ السيناريو JSON 📋", "en": "Copy Scenario JSON 📋" },
            "toast_copy": { "ar": "تم نسخ السيناريو إلى الحافظة بنجاح!", "en": "Scenario JSON copied to clipboard successfully!" },
            "steps_lbl": { "ar": "الخطوات الفنية للتنفيذ:", "en": "Technical Execution Steps:" },
            "result_lbl": { "ar": "النتيجة المتوقعة:", "en": "Expected Outcome:" },
            "click_expand": { "ar": "انقر للتوسيع أو الإغلاق التفصيلي", "en": "Click to expand/collapse details" },

            // Glossary Terms
            "gl_builder_title": { "ar": "@builder (منشئ الملفات تلقائياً)", "en": "@builder (Auto File Scaffolder)" },
            "gl_builder_desc": { "ar": "التوجيه البرمجي الأساسي المسؤول عن كتابة وتحديث الملفات على القرص الصلب وتصنيفها في المجلدات المناسبة.", "en": "The primary code directive responsible for writing and updating files on disk in their correct locations." },
            "gl_builder_ex": { "ar": "مثال: // @builder:file app/src/main.py", "en": "Example: // @builder:file app/src/main.py" },

            "gl_executor_title": { "ar": "@executor (منفذ الأوامر الآمن)", "en": "@executor (Secure Command Runner)" },
            "gl_executor_desc": { "ar": "توجيه تشغيل الأوامر والعمليات الفنية مثل فرز الملفات، أرشفة المشروع، والتشخيص الذاتي في بيئة معزولة.", "en": "The directive to execute system operations like sorting files, archiving projects, and safe terminal routines in an isolated workspace." },
            "gl_executor_ex": { "ar": "مثال: // @executor: scan_duplicates", "en": "Example: // @executor: scan_duplicates" },

            "gl_treedoc_title": { "ar": "@treedoc (مخطط بنية المشاريع)", "en": "@treedoc (Project Tree Blueprint)" },
            "gl_treedoc_desc": { "ar": "أداة ذكية لتوليد خرائط شجرية هرمية للمجلدات لمساعدتك ومساعدة الذكاء الاصطناعي على فهم ترتيب الكود البرمجي.", "en": "Smart tool that generates visual folder tree diagrams to give AI models a high-level view of your workspace layout." },
            "gl_treedoc_ex": { "ar": "مثال: // @treedoc: html", "en": "Example: // @treedoc: html" },

            "gl_smartinbox_title": { "ar": "SmartInbox (صندوق الالتقاط الذكي)", "en": "SmartInbox (Visual Snippet Collector)" },
            "gl_smartinbox_desc": { "ar": "نظام الالتقاط الفوري أعلى الشاشة الذي يستقبل قصاصات الكود، يعالجها بتنسيقات CSS، ويحفظها كملفات أو في SQLite.", "en": "The real-time screen scraping widget that captures screen text, beautifies it via CSS templates, and stores it locally or in SQLite." },
            "gl_smartinbox_ex": { "ar": "مثال: تفعيل ميزة Smart Capture وتصدير المستند بصيغة مذهلة.", "en": "Example: Activate Smart Capture and export visually-beautified dark documents." },

            // FAQs
            "faq_privacy_q": { "ar": "س: كيف يتم التعامل مع البيانات والخصوصية بالمنصة؟", "en": "Q: How does the platform handle security and privacy?" },
            "faq_privacy_a": { "ar": "ج: المنصة مبنية على مبدأ 'الخصوصية أولاً'. يتم تخزين كافة السجلات والالتقاطات محلياً بنسبة 100% داخل قاعدة بيانات SQLite آمنة على جهازك، دون أي اتصال بخوادم خارجية إلا عند استدعاء Gemini API.", "en": "A: The system is designed with an offline-first privacy mindset. All logs and captures are stored locally on your physical system inside an encrypted SQLite database; no outbound transmissions occur unless using Gemini API." },

            "faq_backup_q": { "ar": "س: كيف يعمل نظام النسخ الاحتياطي التلقائي (Auto-Backup)؟", "en": "Q: How does the Automatic Backup system work?" },
            "faq_backup_a": { "ar": "ج: قبل كتابة أو تحديث أي ملف بالكمبيوتر عبر توجيهات @builder، يحتفظ المحرك بنسخة احتياطية في مجلد Backups لضمان عدم فقدان عملك وتسهيل التراجع بلمسة زر.", "en": "A: Prior to modifying or saving any local file, the engine automatically copies and archives the original code inside the Backups directory so you never lose previous iterations." },

            "faq_files_q": { "ar": "س: كيف أتحكم بمسار العمل والملفات النشطة؟", "en": "Q: How do I change and manage my active project folder?" },
            "faq_files_a": { "ar": "ج: يمكنك ذلك بسهولة من شاشة 'الإعدادات والمؤشرات العامة'. حدد مجلد العمل الافتراضي النشط، وسيقوم متصفح المجلدات والمنفذ التلقائي بالتركيز عليه فوراً.", "en": "A: Simply navigate to the Advanced Preferences panel. Select your preferred active folder workspace, and the file manager and background engine will automatically anchor all actions to that path." },

            "faq_context_q": { "ar": "س: ما هي وظيفة مدير سياق المشروع (Project Context Manager)؟", "en": "Q: What is the Project Context Manager's job?" },
            "faq_context_a": { "ar": "ج: يقوم بمراقبة وتتبع كافة الملفات التي يتم إنشاؤها أو تعديلها، ويرسم ملف سياق موحد يسهل نسخه لتقديمه للذكاء الاصطناعي ليكون على دراية تامة بهيكل كودك.", "en": "A: It tracks changes, new files, and modifications across your workspace to construct a unified schema file, allowing you to feed updated code structures to LLMs smoothly." },

            // Scenarios
            "sc_1_title": { "ar": "🎬 سيناريو 1: أتمتة تصدير واستخلاص كتل الأكواد الكبيرة", "en": "🎬 Scenario 1: Bulk Automated Code Extraction" },
            "sc_1_desc": { "ar": "تصدير حزم برمجية متعددة الملفات من المساعد وكتابتها تلقائياً.", "en": "Generate a multi-file template in ChatGPT and write it directly to folders via clipboard hook." },
            "sc_1_steps": { "ar": "1. قم بصياغة طلبك للمساعد (مثلاً: ابني تطبيق ويب بسيط).\n2. يقوم المساعد بتغليف الملفات بـ @builder:file <path> و @builder:end.\n3. بمجرد نسخ الرد، يلتقطه المحرك ويكتب الملفات على القرص في ثانية واحدة.", "en": "1. Prompt your developer assistant (e.g., Build a complete React web layout).\n2. AI responds enclosing files inside @builder blocks.\n3. Copy the response; the Golden Engine intercepts, makes backups, and writes files instantly." },
            "sc_1_res": { "ar": "إنشاء هيكل المشروع كاملاً على جهازك محلياً مع تسجيل الإجراء كعملية ناجحة في قاعدة البيانات.", "en": "The complete project structure scaffolding is written on disk and logged inside your SQLite storage." },

            "sc_2_title": { "ar": "🎬 سيناريو 2: الأرشفة وتنظيف الملفات المكررة والتشخيص", "en": "🎬 Scenario 2: Project Archiving & Self-Diagnostic Scan" },
            "sc_2_desc": { "ar": "أتمتة الفحص الذاتي وترتيب المجلدات وتنظيفها من الملفات المؤقتة.", "en": "Triggering diagnostic checks and cleaning directories from redundant temp files safely." },
            "sc_2_steps": { "ar": "1. نسخ توجيه التنفيذ الخاص بالأرشفة والمسح الشامل.\n2. يلتقط المحرك التوجيه ويقوم بتشغيل مدقق الملفات الآمن محلياً.\n3. يتم فرز وتصنيف الأصول ونقل المكررات لمجلد العزل.", "en": "1. Copy executor template command specifying safe archiving.\n2. System detects @executor script trigger and runs secure file validators locally.\n3. Cleans, organizes, and transfers duplicate segments to isolation folders." },
            "sc_2_res": { "ar": "مساحة تخزين خالية من الملفات التالفة مع تقرير أداء مذهل في لوحة التشخيص.", "en": "Optimized project folder with comprehensive success summary reported inside the diagnostics panel." },

            "sc_3_title": { "ar": "🎬 سيناريو 3: حفظ وتنظيم الملاحظات وتجميل التنسيق CSS", "en": "🎬 Scenario 3: Smart Capturing & Visual CSS Document Design" },
            "sc_3_desc": { "ar": "التقاط فوري للنصوص وتصديرها بلمسات جمالية حديثة.", "en": "Scraping code logs from screens and converting them to polished styled dark cards." },
            "sc_3_steps": { "ar": "1. تفعيل الفقاعة العائمة (Smart Golden Bubble).\n2. تحديد ونسخ أي كود أو شرح مفيد من المتصفح أو بيئة التطوير.\n3. يقوم صندوق الوارد بمعالجة النص وتحويله بـ CSS إلى صفحة HTML أنيقة.", "en": "1. Enable the Golden Floating Bubble overlay.\n2. Copy any useful code snippet, log, or guide from stack overflow or a browser.\n3. The SmartInbox intercepts, applies custom CSS themes, and exports a premium styled dark document." },
            "sc_3_res": { "ar": "مستندات جاهزة للمذاكرة والمشاركة الفورية بدقة بصرية متناهية.", "en": "Highly polished, beautiful interactive visual notes ready for sharing and review." },

            "sc_4_title": { "ar": "🎬 سيناريو 4: توليد تقارير الخرائط الشجرية ومشاركتها مع LLMs", "en": "🎬 Scenario 4: Generating Folder Blueprints for context-sharing" },
            "sc_4_desc": { "ar": "رسم شجرة المجلدات الحالية لتقديم سياق واضح للمساعد الذكي.", "en": "Creating visual blueprints of code architecture to feed into LLMs." },
            "sc_4_steps": { "ar": "1. نسخ توجيه // @treedoc: txt في الحافظة.\n2. يقوم محرك التوليد بمسح المجلد النشط وبناء الهيكل الهرمي.\n3. يتم نسخ الشجرة الناتجة تلقائياً لحافظتك لتضمينها بطلبك القادم.", "en": "1. Copy the // @treedoc: txt directive payload.\n2. The engine generates a beautiful folder hierarchy mapping active workspace.\n3. The resulting map is placed onto your clipboard to feed as a context package to any LLM." },
            "sc_4_res": { "ar": "خريطة نصية هرمية للمشروع تضمن دقة إجابة الذكاء الاصطناعي بنسبة 100%.", "en": "A clear hierarchical text diagram of your workspace ensuring perfect LLM alignment." },

            // Simulator
            "sim_intro": { "ar": "لوحة محاكاة معالجة الأكواد والأوامر التفاعلية (Interactive Live Engine Simulator)", "en": "Interactive Live Engine Simulator & Clipboard Monitor Simulation" },
            "sim_desc": { "ar": "انقر على زر التشغيل بالأسفل لمشاهدة دورة معالجة الحافظة من لحظة الالتقاط، عبر فحص السلامة، حتى حفظ التعديلات وإطلاق الإشعار.", "en": "Press the simulation trigger below to visual-test the step-by-step processing workflow of clipboard payloads, security parsing, file transactions, and SQLite records." },
            "sim_stage_1": { "ar": "📋 المرحلة 1: التقاط الحافظة (Clipboard Intercept)", "en": "📋 Stage 1: Clipboard Intercept" },
            "sim_stage_2": { "ar": "🧠 المرحلة 2: فحص البنية والتحقق الأمني (Regex Analysis)", "en": "🧠 Stage 2: Structural Integrity Analysis" },
            "sim_stage_3": { "ar": "⚡ المرحلة 3: تفعيل تدابير الأمان والنسخ الاحتياطي (Backup creation)", "en": "⚡ Stage 3: Integrity Shield & Backup Routines" },
            "sim_stage_4": { "ar": "📁 المرحلة 4: كتابة الملفات وتسجيل Telemetry بقاعدة SQLite", "en": "📁 Stage 4: SQLite Database Ledger Transaction" },
            "sim_stage_5": { "ar": "🏆 المرحلة 5: إطلاق الإشعارات الصوتية والفقاعة الذهبية", "en": "🏆 Stage 5: Overlay Render & HUD Notification" },
            "sim_state_idle": { "ar": "جاهز ومستعد لتشغيل المحاكاة 🟢", "en": "Ready to simulate engine cycle 🟢" },
            "sim_state_running": { "ar": "⚙️ جاري تشغيل دورة المعالجة النشطة للمحرك...", "en": "⚙️ Engine cycle actively processing..." },
            "sim_state_finished": { "ar": "✨ تم الانتهاء بنجاح! تم حفظ السجلات وتحديث واجهات النظام 👑", "en": "✨ Cycle completed successfully! SQLite database synchronized 👑" }
        };
        var isAr = (backend.appLanguage === "ar");
        return translations[key] ? (isAr ? translations[key]["ar"] : translations[key]["en"]) : "";
    }

    // Interactive simulator state properties
    property int simStep: 0
    property string simStatusText: root.getTxt("sim_state_idle")
    property real simProgress: 0.0

    // ListModel for live simulator logs
    ListModel {
        id: simLogModel
    }

    Timer {
        id: simTimer
        interval: 1000
        repeat: true
        onTriggered: {
            simStep += 1
            if (simStep === 1) {
                simProgress = 0.2
                simStatusText = root.getTxt("sim_stage_1")
                simLogModel.append({ "msg": (backend.appLanguage === "ar" ? "[14:45:01] -> تم التقاط مصفوفة بايتات جديدة من حافظة النظام بنجاح..." : "[14:45:01] -> Intercepted new binary byte buffer from Windows clipboard successfully.") })
                simLogModel.append({ "msg": (backend.appLanguage === "ar" ? "[14:45:01] -> طول النص الملتقط: 1,420 حرفاً." : "[14:45:01] -> Length of captured block: 1,420 characters.") })
            }
            else if (simStep === 2) {
                simProgress = 0.4
                simStatusText = root.getTxt("sim_stage_2")
                simLogModel.append({ "msg": (backend.appLanguage === "ar" ? "[14:45:02] -> جاري تشغيل مفسر الأنماط ومطابقة الرموز التوجيهية..." : "[14:45:02] -> Parsing structural regex and verifying safe build directives...") })
                simLogModel.append({ "msg": (backend.appLanguage === "ar" ? "[14:45:02] -> تم العثور على توجيه صالح لإنشاء الملف: index.html" : "[14:45:02] -> Valid directive detected: @builder:file index.html") })
            }
            else if (simStep === 3) {
                simProgress = 0.6
                simStatusText = root.getTxt("sim_stage_3")
                simLogModel.append({ "msg": (backend.appLanguage === "ar" ? "[14:45:03] -> فحص الأمان: الملف المطلب تعديله آمن تماماً." : "[14:45:03] -> Safety verification complete: file action confirmed safe.") })
                simLogModel.append({ "msg": (backend.appLanguage === "ar" ? "[14:45:03] -> جاري أرشفة النسخة السابقة للملف داخل مجلد Backups/..." : "[14:45:03] -> Archiving current file inside Backups/index_backup.html...") })
            }
            else if (simStep === 4) {
                simProgress = 0.8
                simStatusText = root.getTxt("sim_stage_4")
                simLogModel.append({ "msg": (backend.appLanguage === "ar" ? "[14:45:04] -> جاري كتابة التعديلات البرمجية على القرص الصلب..." : "[14:45:04] -> Writing newly compiled code snippets to target filesystem...") })
                simLogModel.append({ "msg": (backend.appLanguage === "ar" ? "[14:45:04] -> تحديث السجل في SQLite: إضافة سجل نجاح برقم معاملة #1024." : "[14:45:04] -> Registering event transaction #1024 inside SQLite DB log table.") })
            }
            else if (simStep === 5) {
                simProgress = 1.0
                simStatusText = root.getTxt("sim_state_finished")
                simLogModel.append({ "msg": (backend.appLanguage === "ar" ? "[14:45:05] -> إطلاق إشعار نجاح فوري للمطور في الفقاعة الذهبية Floating Bubble!" : "[14:45:05] -> Pushing HUD completion notification and updating active bubble overlay!") })
                simLogModel.append({ "msg": (backend.appLanguage === "ar" ? "[14:45:05] -> محاكي الأتمتة مستعد للتشغيل مجدداً 👑" : "[14:45:05] -> Engine simulation cycle fully completed. Golden system ready 👑") })
                backend.notificationSent(backend.appLanguage === "ar" ? "اكتمال المحاكاة" : "Simulation Completed", backend.appLanguage === "ar" ? "تم بنجاح محاكاة دورة المعالجة للمنصة الذهبية!" : "Successfully completed Golden Platform cycle simulation!", "success")
                simTimer.stop()
            }
        }
    }

    function runSimulation() {
        simStep = 0
        simProgress = 0.0
        simStatusText = root.getTxt("sim_state_running")
        simLogModel.clear()
        simLogModel.append({ "msg": (backend.appLanguage === "ar" ? "⚡ جاري تشغيل محاكي الأتمتة..." : "⚡ Launching platform flow simulation...") })
        simTimer.start()
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
                    text: "📖"
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

        // Tab Bar
        TabBar {
            id: helpTabBar
            Layout.fillWidth: true
            background: Rectangle {
                color: slateBg
                border.color: borderSlate
                radius: 6
            }

            TabButton {
                text: root.getTxt("tab_glossary")
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
                text: root.getTxt("tab_faq")
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
                text: root.getTxt("tab_scenarios")
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
                text: root.getTxt("tab_simulator")
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

        // Tab Content
        StackLayout {
            id: helpStack
            currentIndex: helpTabBar.currentIndex
            Layout.fillWidth: true
            Layout.fillHeight: true

            // TAB 1: Glossary
            ScrollView {
                clip: true
                ColumnLayout {
                    width: helpStack.width - 20
                    spacing: 12

                    // Term 1
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height + 20
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        ColumnLayout {
                            width: parent.width - 24
                            anchors.centerIn: parent
                            spacing: 6
                            Text { text: root.getTxt("gl_builder_title"); color: metallicGold; font.bold: true; font.pixelSize: 13 }
                            Text { text: root.getTxt("gl_builder_desc"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }
                            Text { text: root.getTxt("gl_builder_ex"); color: warningOrange; font.family: "Courier"; font.pixelSize: 10 }
                        }
                    }

                    // Term 2
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height + 20
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        ColumnLayout {
                            width: parent.width - 24
                            anchors.centerIn: parent
                            spacing: 6
                            Text { text: root.getTxt("gl_executor_title"); color: metallicGold; font.bold: true; font.pixelSize: 13 }
                            Text { text: root.getTxt("gl_executor_desc"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }
                            Text { text: root.getTxt("gl_executor_ex"); color: warningOrange; font.family: "Courier"; font.pixelSize: 10 }
                        }
                    }

                    // Term 3
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height + 20
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        ColumnLayout {
                            width: parent.width - 24
                            anchors.centerIn: parent
                            spacing: 6
                            Text { text: root.getTxt("gl_treedoc_title"); color: metallicGold; font.bold: true; font.pixelSize: 13 }
                            Text { text: root.getTxt("gl_treedoc_desc"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }
                            Text { text: root.getTxt("gl_treedoc_ex"); color: warningOrange; font.family: "Courier"; font.pixelSize: 10 }
                        }
                    }

                    // Term 4
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height + 20
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        ColumnLayout {
                            width: parent.width - 24
                            anchors.centerIn: parent
                            spacing: 6
                            Text { text: root.getTxt("gl_smartinbox_title"); color: metallicGold; font.bold: true; font.pixelSize: 13 }
                            Text { text: root.getTxt("gl_smartinbox_desc"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }
                            Text { text: root.getTxt("gl_smartinbox_ex"); color: warningOrange; font.family: "Courier"; font.pixelSize: 10 }
                        }
                    }
                }
            }

            // TAB 2: FAQ (Expandable Cards)
            ScrollView {
                clip: true
                ColumnLayout {
                    width: helpStack.width - 20
                    spacing: 12

                    // FAQ 1
                    Rectangle {
                        id: faqCard1
                        Layout.fillWidth: true
                        Layout.preferredHeight: expanded ? faqCard1Col.implicitHeight + 24 : 50
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        property bool expanded: false

                        Behavior on Layout.preferredHeight { NumberAnimation { duration: 200 } }

                        ColumnLayout {
                            id: faqCard1Col
                            width: parent.width - 24
                            anchors.top: parent.top
                            anchors.topMargin: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 8

                            RowLayout {
                                Layout.fillWidth: true
                                Text { text: root.getTxt("faq_privacy_q"); color: metallicGold; font.bold: true; font.pixelSize: 12; Layout.fillWidth: true }
                                Text { text: faqCard1.expanded ? "▲" : "▼"; color: textGray; font.pixelSize: 10 }
                            }

                            Text {
                                text: root.getTxt("faq_privacy_a")
                                color: textSilver
                                font.pixelSize: 11
                                wrapMode: Text.Wrap
                                Layout.fillWidth: true
                                visible: faqCard1.expanded
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: faqCard1.expanded = !faqCard1.expanded
                        }
                    }

                    // FAQ 2
                    Rectangle {
                        id: faqCard2
                        Layout.fillWidth: true
                        Layout.preferredHeight: expanded ? faqCard2Col.implicitHeight + 24 : 50
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        property bool expanded: false

                        Behavior on Layout.preferredHeight { NumberAnimation { duration: 200 } }

                        ColumnLayout {
                            id: faqCard2Col
                            width: parent.width - 24
                            anchors.top: parent.top
                            anchors.topMargin: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 8

                            RowLayout {
                                Layout.fillWidth: true
                                Text { text: root.getTxt("faq_backup_q"); color: metallicGold; font.bold: true; font.pixelSize: 12; Layout.fillWidth: true }
                                Text { text: faqCard2.expanded ? "▲" : "▼"; color: textGray; font.pixelSize: 10 }
                            }

                            Text {
                                text: root.getTxt("faq_backup_a")
                                color: textSilver
                                font.pixelSize: 11
                                wrapMode: Text.Wrap
                                Layout.fillWidth: true
                                visible: faqCard2.expanded
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: faqCard2.expanded = !faqCard2.expanded
                        }
                    }

                    // FAQ 3
                    Rectangle {
                        id: faqCard3
                        Layout.fillWidth: true
                        Layout.preferredHeight: expanded ? faqCard3Col.implicitHeight + 24 : 50
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        property bool expanded: false

                        Behavior on Layout.preferredHeight { NumberAnimation { duration: 200 } }

                        ColumnLayout {
                            id: faqCard3Col
                            width: parent.width - 24
                            anchors.top: parent.top
                            anchors.topMargin: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 8

                            RowLayout {
                                Layout.fillWidth: true
                                Text { text: root.getTxt("faq_files_q"); color: metallicGold; font.bold: true; font.pixelSize: 12; Layout.fillWidth: true }
                                Text { text: faqCard3.expanded ? "▲" : "▼"; color: textGray; font.pixelSize: 10 }
                            }

                            Text {
                                text: root.getTxt("faq_files_a")
                                color: textSilver
                                font.pixelSize: 11
                                wrapMode: Text.Wrap
                                Layout.fillWidth: true
                                visible: faqCard3.expanded
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: faqCard3.expanded = !faqCard3.expanded
                        }
                    }

                    // FAQ 4
                    Rectangle {
                        id: faqCard4
                        Layout.fillWidth: true
                        Layout.preferredHeight: expanded ? faqCard4Col.implicitHeight + 24 : 50
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        property bool expanded: false

                        Behavior on Layout.preferredHeight { NumberAnimation { duration: 200 } }

                        ColumnLayout {
                            id: faqCard4Col
                            width: parent.width - 24
                            anchors.top: parent.top
                            anchors.topMargin: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 8

                            RowLayout {
                                Layout.fillWidth: true
                                Text { text: root.getTxt("faq_context_q"); color: metallicGold; font.bold: true; font.pixelSize: 12; Layout.fillWidth: true }
                                Text { text: faqCard4.expanded ? "▲" : "▼"; color: textGray; font.pixelSize: 10 }
                            }

                            Text {
                                text: root.getTxt("faq_context_a")
                                color: textSilver
                                font.pixelSize: 11
                                wrapMode: Text.Wrap
                                Layout.fillWidth: true
                                visible: faqCard4.expanded
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: faqCard4.expanded = !faqCard4.expanded
                        }
                    }
                }
            }

            // TAB 3: Practical Scenarios (Expandable)
            ScrollView {
                clip: true
                ColumnLayout {
                    width: helpStack.width - 20
                    spacing: 12

                    // Scenario 1
                    Rectangle {
                        id: scCard1
                        Layout.fillWidth: true
                        Layout.preferredHeight: expanded ? childrenRect.height + 20 : 70
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 10
                        property bool expanded: false

                        Behavior on Layout.preferredHeight { NumberAnimation { duration: 200 } }

                        ColumnLayout {
                            width: parent.width - 24
                            anchors.top: parent.top
                            anchors.topMargin: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 10

                            RowLayout {
                                Layout.fillWidth: true
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    Text { text: root.getTxt("sc_1_title"); color: metallicGold; font.bold: true; font.pixelSize: 12 }
                                    Text { text: root.getTxt("sc_1_desc"); color: textGray; font.pixelSize: 10 }
                                }
                                Text { text: scCard1.expanded ? "▲" : "▼"; color: textGray; font.pixelSize: 10 }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8
                                visible: scCard1.expanded

                                Text { text: root.getTxt("steps_lbl"); color: softGold; font.bold: true; font.pixelSize: 11 }
                                Text { text: root.getTxt("sc_1_steps"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }

                                Text { text: root.getTxt("result_lbl"); color: successGreen; font.bold: true; font.pixelSize: 11 }
                                Text { text: root.getTxt("sc_1_res"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }

                                Button {
                                    text: root.getTxt("btn_copy_json")
                                    Layout.alignment: Qt.AlignRight
                                    onClicked: {
                                        var json = '{\n  "title": "Bulk Automated Code Extraction",\n  "type": "builder_pack",\n  "expected_files": ["index.html", "style.css", "app.js"]\n}';
                                        backend.set_setting("clipboard_monitor", "false");
                                        backend.execute_command_advanced("clipboard " + json, "", false);
                                        backend.set_setting("clipboard_monitor", "true");
                                        backend.notificationSent(backend.appLanguage === "ar" ? "نسخ السيناريو" : "Copy Scenario", root.getTxt("toast_copy"), "success");
                                    }
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            enabled: !scCard1.expanded // let child buttons work when expanded
                            onClicked: scCard1.expanded = true
                        }

                        // transparent mousearea at header to toggle collapse when expanded
                        MouseArea {
                            height: 60
                            width: parent.width
                            anchors.top: parent.top
                            visible: scCard1.expanded
                            onClicked: scCard1.expanded = false
                        }
                    }

                    // Scenario 2
                    Rectangle {
                        id: scCard2
                        Layout.fillWidth: true
                        Layout.preferredHeight: expanded ? childrenRect.height + 20 : 70
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 10
                        property bool expanded: false

                        Behavior on Layout.preferredHeight { NumberAnimation { duration: 200 } }

                        ColumnLayout {
                            width: parent.width - 24
                            anchors.top: parent.top
                            anchors.topMargin: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 10

                            RowLayout {
                                Layout.fillWidth: true
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    Text { text: root.getTxt("sc_2_title"); color: metallicGold; font.bold: true; font.pixelSize: 12 }
                                    Text { text: root.getTxt("sc_2_desc"); color: textGray; font.pixelSize: 10 }
                                }
                                Text { text: scCard2.expanded ? "▲" : "▼"; color: textGray; font.pixelSize: 10 }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8
                                visible: scCard2.expanded

                                Text { text: root.getTxt("steps_lbl"); color: softGold; font.bold: true; font.pixelSize: 11 }
                                Text { text: root.getTxt("sc_2_steps"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }

                                Text { text: root.getTxt("result_lbl"); color: successGreen; font.bold: true; font.pixelSize: 11 }
                                Text { text: root.getTxt("sc_2_res"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }

                                Button {
                                    text: root.getTxt("btn_copy_json")
                                    Layout.alignment: Qt.AlignRight
                                    onClicked: {
                                        var json = '{\n  "title": "Project Archiving & Diagnostics",\n  "type": "executor",\n  "commands": ["clean", "archive", "duplicates"]\n}';
                                        backend.set_setting("clipboard_monitor", "false");
                                        backend.execute_command_advanced("clipboard " + json, "", false);
                                        backend.set_setting("clipboard_monitor", "true");
                                        backend.notificationSent(backend.appLanguage === "ar" ? "نسخ السيناريو" : "Copy Scenario", root.getTxt("toast_copy"), "success");
                                    }
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            enabled: !scCard2.expanded
                            onClicked: scCard2.expanded = true
                        }

                        MouseArea {
                            height: 60
                            width: parent.width
                            anchors.top: parent.top
                            visible: scCard2.expanded
                            onClicked: scCard2.expanded = false
                        }
                    }

                    // Scenario 3
                    Rectangle {
                        id: scCard3
                        Layout.fillWidth: true
                        Layout.preferredHeight: expanded ? childrenRect.height + 20 : 70
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 10
                        property bool expanded: false

                        Behavior on Layout.preferredHeight { NumberAnimation { duration: 200 } }

                        ColumnLayout {
                            width: parent.width - 24
                            anchors.top: parent.top
                            anchors.topMargin: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 10

                            RowLayout {
                                Layout.fillWidth: true
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    Text { text: root.getTxt("sc_3_title"); color: metallicGold; font.bold: true; font.pixelSize: 12 }
                                    Text { text: root.getTxt("sc_3_desc"); color: textGray; font.pixelSize: 10 }
                                }
                                Text { text: scCard3.expanded ? "▲" : "▼"; color: textGray; font.pixelSize: 10 }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8
                                visible: scCard3.expanded

                                Text { text: root.getTxt("steps_lbl"); color: softGold; font.bold: true; font.pixelSize: 11 }
                                Text { text: root.getTxt("sc_3_steps"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }

                                Text { text: root.getTxt("result_lbl"); color: successGreen; font.bold: true; font.pixelSize: 11 }
                                Text { text: root.getTxt("sc_3_res"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }

                                Button {
                                    text: root.getTxt("btn_copy_json")
                                    Layout.alignment: Qt.AlignRight
                                    onClicked: {
                                        var json = '{\n  "title": "Smart Capturing CSS Beautifier",\n  "type": "smart_capture",\n  "theme": "oasis"\n}';
                                        backend.set_setting("clipboard_monitor", "false");
                                        backend.execute_command_advanced("clipboard " + json, "", false);
                                        backend.set_setting("clipboard_monitor", "true");
                                        backend.notificationSent(backend.appLanguage === "ar" ? "نسخ السيناريو" : "Copy Scenario", root.getTxt("toast_copy"), "success");
                                    }
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            enabled: !scCard3.expanded
                            onClicked: scCard3.expanded = true
                        }

                        MouseArea {
                            height: 60
                            width: parent.width
                            anchors.top: parent.top
                            visible: scCard3.expanded
                            onClicked: scCard3.expanded = false
                        }
                    }

                    // Scenario 4
                    Rectangle {
                        id: scCard4
                        Layout.fillWidth: true
                        Layout.preferredHeight: expanded ? childrenRect.height + 20 : 70
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 10
                        property bool expanded: false

                        Behavior on Layout.preferredHeight { NumberAnimation { duration: 200 } }

                        ColumnLayout {
                            width: parent.width - 24
                            anchors.top: parent.top
                            anchors.topMargin: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 10

                            RowLayout {
                                Layout.fillWidth: true
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    Text { text: root.getTxt("sc_4_title"); color: metallicGold; font.bold: true; font.pixelSize: 12 }
                                    Text { text: root.getTxt("sc_4_desc"); color: textGray; font.pixelSize: 10 }
                                }
                                Text { text: scCard4.expanded ? "▲" : "▼"; color: textGray; font.pixelSize: 10 }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8
                                visible: scCard4.expanded

                                Text { text: root.getTxt("steps_lbl"); color: softGold; font.bold: true; font.pixelSize: 11 }
                                Text { text: root.getTxt("sc_4_steps"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }

                                Text { text: root.getTxt("result_lbl"); color: successGreen; font.bold: true; font.pixelSize: 11 }
                                Text { text: root.getTxt("sc_4_res"); color: textSilver; font.pixelSize: 11; wrapMode: Text.Wrap; Layout.fillWidth: true }

                                Button {
                                    text: root.getTxt("btn_copy_json")
                                    Layout.alignment: Qt.AlignRight
                                    onClicked: {
                                        var json = '{\n  "title": "TreeDoc Context Builder",\n  "type": "treedoc_report",\n  "format": "txt"\n}';
                                        backend.set_setting("clipboard_monitor", "false");
                                        backend.execute_command_advanced("clipboard " + json, "", false);
                                        backend.set_setting("clipboard_monitor", "true");
                                        backend.notificationSent(backend.appLanguage === "ar" ? "نسخ السيناريو" : "Copy Scenario", root.getTxt("toast_copy"), "success");
                                    }
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            enabled: !scCard4.expanded
                            onClicked: scCard4.expanded = true
                        }

                        MouseArea {
                            height: 60
                            width: parent.width
                            anchors.top: parent.top
                            visible: scCard4.expanded
                            onClicked: scCard4.expanded = false
                        }
                    }
                }
            }

            // TAB 4: Automation Simulator
            ColumnLayout {
                spacing: 12

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

                        Text {
                            text: root.getTxt("sim_intro")
                            color: metallicGold
                            font.bold: true
                            font.pixelSize: 13
                        }

                        Text {
                            text: root.getTxt("sim_desc")
                            color: textSilver
                            font.pixelSize: 11
                            wrapMode: Text.Wrap
                            Layout.fillWidth: true
                        }

                        // Progress Indicator
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 10

                            Text {
                                text: Math.round(root.simProgress * 100) + "%"
                                color: metallicGold
                                font.bold: true
                                font.pixelSize: 12
                            }

                            // Custom animated gold progress bar
                            Rectangle {
                                Layout.fillWidth: true
                                height: 10
                                color: slateBg
                                border.color: borderSlate
                                radius: 5
                                clip: true

                                Rectangle {
                                    width: parent.width * root.simProgress
                                    height: parent.height
                                    color: successGreen
                                    radius: 5

                                    Behavior on width {
                                        NumberAnimation { duration: 400; easing.type: Easing.OutQuad }
                                    }
                                }
                            }
                        }

                        Text {
                            text: root.simStatusText
                            color: softGold
                            font.bold: true
                            font.pixelSize: 11
                        }

                        Button {
                            text: root.getTxt("btn_simulate")
                            onClicked: root.runSimulation()
                        }
                    }
                }

                // Simulation Terminal Logs
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: slateBg
                    border.color: borderSlate
                    radius: 8

                    ScrollView {
                        anchors.fill: parent
                        clip: true

                        ListView {
                            id: simLogsListView
                            model: simLogModel
                            spacing: 6
                            anchors.margins: 10

                            delegate: Text {
                                width: simLogsListView.width - 20
                                text: model.msg
                                color: model.msg.indexOf("❌") !== -1 ? errorRed : (model.msg.indexOf("✨") !== -1 ? successGreen : textSilver)
                                font.family: "Courier"
                                font.pixelSize: 11
                                wrapMode: Text.Wrap
                            }
                        }
                    }
                }
            }
        }
    }
}
