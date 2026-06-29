import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: onboardingRoot
    anchors.fill: parent
    color: "#05070E" // Fallback dark golden-slate

    // Theme values (referenced dynamically from parent or local loaders)
    // We can load active theme dynamically so that selecting a theme updates Onboarding instantly!
    property var currentColors: loadLocalColors(backend.activeTheme)

    readonly property color slateBg: currentColors.slateBg
    readonly property color cardSlateBg: currentColors.cardSlateBg
    readonly property color borderSlate: currentColors.borderSlate
    readonly property color metallicGold: currentColors.metallicGold
    readonly property color softGold: currentColors.softGold
    readonly property color textSilver: currentColors.textSilver
    readonly property color textGray: "#8A94A6"

    signal completed()

    function loadLocalColors(themeId) {
        var themes = {
            "golden_slate": { "slateBg": "#05070E", "cardSlateBg": "#0D1127", "borderSlate": "#1E295D", "metallicGold": "#FCD34D", "softGold": "#FDE047", "textSilver": "#E4E9FC" },
            "emerald_oasis": { "slateBg": "#030A07", "cardSlateBg": "#091D15", "borderSlate": "#1B4D3E", "metallicGold": "#FCD34D", "softGold": "#E6C645", "textSilver": "#E2F1EC" },
            "royal_crimson": { "slateBg": "#0F0206", "cardSlateBg": "#21050E", "borderSlate": "#541225", "metallicGold": "#FCD34D", "softGold": "#FCD34D", "textSilver": "#FCE4EC" },
            "deep_space": { "slateBg": "#030303", "cardSlateBg": "#121212", "borderSlate": "#2D2D2D", "metallicGold": "#FCD34D", "softGold": "#FFF59D", "textSilver": "#EEEEEE" },
            "oceanic_blue": { "slateBg": "#020B14", "cardSlateBg": "#071B2D", "borderSlate": "#153E5C", "metallicGold": "#FCD34D", "softGold": "#81D4FA", "textSilver": "#E1F5FE" },
            "pastel_mint": { "slateBg": "#FAFDFC", "cardSlateBg": "#F0F7F4", "borderSlate": "#CCE3DE", "metallicGold": "#D97706", "softGold": "#FBBF24", "textSilver": "#1E293B" },
            "solar_amber": { "slateBg": "#140D02", "cardSlateBg": "#2D1C05", "borderSlate": "#5C3E0C", "metallicGold": "#FCD34D", "softGold": "#FFE082", "textSilver": "#FFF8E1" },
            "charcoal": { "slateBg": "#111111", "cardSlateBg": "#1A1A1A", "borderSlate": "#333333", "metallicGold": "#E5A93B", "softGold": "#E5A93B", "textSilver": "#E0E0E0" },
            "cyberpunk": { "slateBg": "#0F051D", "cardSlateBg": "#1D0D33", "borderSlate": "#4E129B", "metallicGold": "#F15BB5", "softGold": "#00F5D4", "textSilver": "#FFEEFF" },
            "arctic_frost": { "slateBg": "#F4F7F6", "cardSlateBg": "#E9EFF1", "borderSlate": "#B0C4DE", "metallicGold": "#4682B4", "softGold": "#87CEFA", "textSilver": "#2F4F4F" }
        };
        return themes[themeId] || themes["golden_slate"];
    }

    // Arabic and English Translations for Onboarding
    function getTxt(key) {
        var translations = {
            "btn_next": { "ar": "التالي ➡️", "en": "Next ➡️" },
            "btn_prev": { "ar": "⬅️ السابق", "en": "⬅️ Previous" },
            "btn_skip": { "ar": "تخطي ⏩", "en": "Skip ⏩" },
            "btn_finish": { "ar": "انطلق للتحفة الفنية! 👑🚀", "en": "Launch the Masterpiece! 👑🚀" },
            
            // Page 1
            "p1_title": { "ar": "🌟 أهلاً بك في عالمك الجديد", "en": "🌟 Welcome to Your New World" },
            "p1_desc": { "ar": "المنصة الذهبية الذكية Pro هي بوابتك المتكاملة للأتمتة الفائقة وتنظيم الملفات وبناء المشاريع بلمحة بصر. لقد صممنا هذا المحرك ليلبي جميع احتياجاتك اليومية والبرمجية بكفاءة لا مثيل لها وبجودة أداء سينمائية ممتازة.", "en": "The Golden Intelligent Platform Pro is your unified gateway for extreme automation, file organization, and fast project building. We built this engine to fulfill your daily and developer needs with unparalleled speed and cinematic fluid design." },
            
            // Page 2
            "p2_title": { "ar": "💻 بيئة متكاملة للمطورين المحترفين", "en": "💻 Integrated Pro Developer Environment" },
            "p2_desc": { "ar": "قم ببناء وتصدير الكود المصدري وتجميع المجلدات بلمسة واحدة عبر حزم @builder الذكية. يقوم النظام تلقائياً برصد الحافظة ونسخ الملفات لتعمل بسلاسة كاملة وتوفر ساعات من وقت التطوير اليدوي.", "en": "Pack, compile, and export source code instantly with smart @builder packages. The platform monitors your clipboard for packages and manages workspace transfers automatically, saving hours of manual workflow setup." },
            
            // Page 3
            "p3_title": { "ar": "🎓 البوابة البرمجية للأكاديميين والباحثين", "en": "🎓 Academic and Research Portal" },
            "p3_desc": { "ar": "قم بصياغة التقارير الفنية، واستخراج المراجع البحثية، والتقاط النصوص والمقالات بذكاء وتجميلها مرئياً بصيغة Markdown الغنية بنظام TreeDoc Pro المتطور. كل ملفاتك منظمة في قاعدة بيانات محلیة فائقة الأمان.", "en": "Draft technical documents, extract bibliographic references, and capture notes elegantly with smart visual beautification of rich Markdown, using our advanced TreeDoc Pro. All your files are organized securely in a safe local database." },
            
            // Page 4
            "p4_title": { "ar": "🎨 اختر السمة والمظهر المفضل لرحلتك", "en": "🎨 Personalize Your Visual Identity" },
            "p4_desc": { "ar": "اختر واحدة من 8 سمات مصممة باحترافية لتناسب ذوقك البصري وعالمك الرقمي. انقر على أي بطاقة لتجربتها مباشرة وتعيينها كسمة افتراضية للمنصة.", "en": "Select one of 8 gorgeous, professionally designed themes to match your digital environment. Click any card to preview instantly and apply it as your default platform style." },

            // Themes names
            "theme_golden_slate": { "ar": "الذهبي الملكي", "en": "Royal Golden Slate" },
            "theme_emerald_oasis": { "ar": "زمرد الواحة", "en": "Emerald Oasis" },
            "theme_royal_crimson": { "ar": "القرمزي الفاخر", "en": "Royal Crimson" },
            "theme_deep_space": { "ar": "الفضاء العميق", "en": "Deep Space" },
            "theme_oceanic_blue": { "ar": "الأزرق المحيطي", "en": "Oceanic Blue" },
            "theme_pastel_mint": { "ar": "نعناع الباستيل", "en": "Pastel Mint" },
            "theme_solar_amber": { "ar": "الكهرمان المشع", "en": "Solar Amber" },
            "theme_charcoal": { "ar": "الفحمي العصري", "en": "Modern Charcoal" },
            "theme_cyberpunk": { "ar": "السيبربنك المستقبلي", "en": "Cyberpunk Neon" },
            "theme_arctic_frost": { "ar": "الصقيع القطبي", "en": "Arctic Frost" }
        };
        var isAr = (backend.appLanguage === "ar");
        return translations[key] ? (isAr ? translations[key]["ar"] : translations[key]["en"]) : "";
    }

    // List of themes for the grid
    ListModel {
        id: themesListModel
        Component.onCompleted: {
            append({ "id": "golden_slate", "color1": "#05070E", "color2": "#FCD34D" })
            append({ "id": "emerald_oasis", "color1": "#030A07", "color2": "#10B981" })
            append({ "id": "royal_crimson", "color1": "#0F0206", "color2": "#EF4444" })
            append({ "id": "deep_space", "color1": "#030303", "color2": "#EEEEEE" })
            append({ "id": "oceanic_blue", "color1": "#020B14", "color2": "#38BDF8" })
            append({ "id": "solar_amber", "color1": "#140D02", "color2": "#F59E0B" })
            append({ "id": "cyberpunk", "color1": "#0F051D", "color2": "#F15BB5" })
            append({ "id": "charcoal", "color1": "#111111", "color2": "#E5A93B" })
        }
    }

    // Background Gradient with smooth transition
    gradient: Gradient {
        GradientStop { position: 0.0; color: slateBg }
        GradientStop { position: 0.5; color: slateBg }
        GradientStop { position: 1.0; color: cardSlateBg }
    }

    // Top Header with Skip Button
    RowLayout {
        id: topBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 25
        height: 50
        z: 10

        Text {
            text: "👑 GOLDEN PLATFORM PRO"
            color: metallicGold
            font.bold: true
            font.pixelSize: 13
            font.letterSpacing: 1.5
        }

        Spacer { Layout.fillWidth: true }

        Button {
            id: skipBtn
            text: onboardingRoot.getTxt("btn_skip")
            visible: swipeView.currentIndex < 3
            onClicked: swipeView.currentIndex = 3 // Jump to theme page

            background: Rectangle {
                color: skipBtn.hovered ? borderSlate : "transparent"
                border.color: borderSlate
                border.width: 1
                radius: 15
            }
            contentItem: Text {
                text: skipBtn.text
                color: metallicGold
                font.bold: true
                font.pixelSize: 11
                leftPadding: 15
                rightPadding: 15
            }
        }
    }

    // Swipe View for Multi-page Carousel
    SwipeView {
        id: swipeView
        anchors.top: topBar.bottom
        anchors.bottom: navigationBar.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        currentIndex: 0
        clip: true

        // PAGE 1: Welcome
        Item {
            id: page1
            ColumnLayout {
                anchors.centerIn: parent
                width: Math.min(parent.width - 40, 700)
                spacing: 20

                // Graphic/Illustration using gorgeous concentric glowing circles and stars
                Item {
                    Layout.preferredWidth: 150
                    Layout.preferredHeight: 150
                    Layout.alignment: Qt.AlignHCenter

                    Rectangle {
                        anchors.fill: parent
                        radius: 75
                        color: borderSlate
                        opacity: 0.15
                    }
                    Text {
                        text: "✨"
                        font.pixelSize: 72
                        anchors.centerIn: parent
                        
                        SequentialAnimation on scale {
                            loops: Animation.Infinite
                            NumberAnimation { from: 0.9; to: 1.1; duration: 1500; easing.type: Easing.InOutSine }
                            NumberAnimation { from: 1.1; to: 0.9; duration: 1500; easing.type: Easing.InOutSine }
                        }
                    }
                }

                Text {
                    text: onboardingRoot.getTxt("p1_title")
                    color: metallicGold
                    font.bold: true
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: onboardingRoot.getTxt("p1_desc")
                    color: textSilver
                    font.pixelSize: 13
                    horizontalAlignment: Text.AlignHCenter
                    lineHeight: 1.5
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                }
            }
        }

        // PAGE 2: Developers
        Item {
            id: page2
            ColumnLayout {
                anchors.centerIn: parent
                width: Math.min(parent.width - 40, 700)
                spacing: 20

                Item {
                    Layout.preferredWidth: 150
                    Layout.preferredHeight: 150
                    Layout.alignment: Qt.AlignHCenter

                    Rectangle {
                        anchors.fill: parent
                        radius: 75
                        color: borderSlate
                        opacity: 0.15
                    }
                    Text {
                        text: "💻"
                        font.pixelSize: 72
                        anchors.centerIn: parent
                        
                        SequentialAnimation on rotation {
                            loops: Animation.Infinite
                            NumberAnimation { from: -5; to: 5; duration: 2000; easing.type: Easing.InOutSine }
                            NumberAnimation { from: 5; to: -5; duration: 2000; easing.type: Easing.InOutSine }
                        }
                    }
                }

                Text {
                    text: onboardingRoot.getTxt("p2_title")
                    color: metallicGold
                    font.bold: true
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: onboardingRoot.getTxt("p2_desc")
                    color: textSilver
                    font.pixelSize: 13
                    horizontalAlignment: Text.AlignHCenter
                    lineHeight: 1.5
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                }
            }
        }

        // PAGE 3: Academics
        Item {
            id: page3
            ColumnLayout {
                anchors.centerIn: parent
                width: Math.min(parent.width - 40, 700)
                spacing: 20

                Item {
                    Layout.preferredWidth: 150
                    Layout.preferredHeight: 150
                    Layout.alignment: Qt.AlignHCenter

                    Rectangle {
                        anchors.fill: parent
                        radius: 75
                        color: borderSlate
                        opacity: 0.15
                    }
                    Text {
                        text: "🎓"
                        font.pixelSize: 72
                        anchors.centerIn: parent
                        
                        SequentialAnimation on scale {
                            loops: Animation.Infinite
                            NumberAnimation { from: 0.95; to: 1.05; duration: 1800; easing.type: Easing.InOutSine }
                            NumberAnimation { from: 1.05; to: 0.95; duration: 1800; easing.type: Easing.InOutSine }
                        }
                    }
                }

                Text {
                    text: onboardingRoot.getTxt("p3_title")
                    color: metallicGold
                    font.bold: true
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: onboardingRoot.getTxt("p3_desc")
                    color: textSilver
                    font.pixelSize: 13
                    horizontalAlignment: Text.AlignHCenter
                    lineHeight: 1.5
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                }
            }
        }

        // PAGE 4: Theme Customization Grid
        Item {
            id: page4
            ColumnLayout {
                anchors.centerIn: parent
                width: Math.min(parent.width - 40, 850)
                spacing: 15

                Text {
                    text: onboardingRoot.getTxt("p4_title")
                    color: metallicGold
                    font.bold: true
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: onboardingRoot.getTxt("p4_desc")
                    color: textSilver
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                    Layout.bottomMargin: 10
                }

                // Grid of Themes
                GridLayout {
                    columns: 4
                    columnSpacing: 12
                    rowSpacing: 12
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter

                    Repeater {
                        model: themesListModel
                        delegate: Rectangle {
                            Layout.fillWidth: true
                            height: 75
                            color: backend.activeTheme === model.id ? borderSlate : cardSlateBg
                            border.color: backend.activeTheme === model.id ? metallicGold : borderSlate
                            border.width: backend.activeTheme === model.id ? 2 : 1
                            radius: 8
                            
                            // Visual Hover feedback
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    backend.activeTheme = model.id
                                }
                            }

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 12
                                spacing: 10

                                // Color preview circle
                                Rectangle {
                                    width: 30
                                    height: 30
                                    radius: 15
                                    color: model.color1
                                    border.color: model.color2
                                    border.width: 1.5

                                    Rectangle {
                                        width: 12
                                        height: 12
                                        radius: 6
                                        color: model.color2
                                        anchors.centerIn: parent
                                    }
                                }

                                ColumnLayout {
                                    spacing: 2
                                    Layout.fillWidth: true
                                    Text {
                                        text: onboardingRoot.getTxt("theme_" + model.id)
                                        color: backend.activeTheme === model.id ? metallicGold : textSilver
                                        font.bold: true
                                        font.pixelSize: 11
                                        elide: Text.ElideRight
                                    }
                                    Text {
                                        text: model.id.replace("_", " ").toUpperCase()
                                        color: textGray
                                        font.pixelSize: 9
                                        elide: Text.ElideRight
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Bottom Navigation Bar
    RowLayout {
        id: navigationBar
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 25
        height: 60
        z: 10

        // Previous Button
        Button {
            id: prevBtn
            text: onboardingRoot.getTxt("btn_prev")
            visible: swipeView.currentIndex > 0
            onClicked: swipeView.currentIndex--

            background: Rectangle {
                color: prevBtn.hovered ? borderSlate : "transparent"
                border.color: borderSlate
                border.width: 1
                radius: 18
            }
            contentItem: Text {
                text: prevBtn.text
                color: textSilver
                font.bold: true
                font.pixelSize: 11
                leftPadding: 15
                rightPadding: 15
            }
        }

        Spacer { Layout.fillWidth: true }

        // Page Dots Indicator
        PageIndicator {
            id: control
            count: swipeView.count
            currentIndex: swipeView.currentIndex
            Layout.alignment: Qt.AlignVCenter

            delegate: Rectangle {
                implicitWidth: 8
                implicitHeight: 8
                radius: 4
                color: index === control.currentIndex ? metallicGold : borderSlate

                Behavior on color {
                    ColorAnimation { duration: 200 }
                }
            }
        }

        Spacer { Layout.fillWidth: true }

        // Next or Finish Button
        Button {
            id: nextBtn
            text: swipeView.currentIndex === 3 ? onboardingRoot.getTxt("btn_finish") : onboardingRoot.getTxt("btn_next")
            
            onClicked: {
                if (swipeView.currentIndex < 3) {
                    swipeView.currentIndex++
                } else {
                    // Save completion in settings
                    backend.set_setting("has_seen_onboarding", "true")
                    // Smooth exit animation
                    fadeOutOnboardingAnim.start()
                }
            }

            background: Rectangle {
                color: swipeView.currentIndex === 3 ? "#1E295D" : (nextBtn.hovered ? borderSlate : "transparent")
                border.color: metallicGold
                border.width: 1
                radius: 18
            }
            contentItem: Text {
                text: nextBtn.text
                color: metallicGold
                font.bold: true
                font.pixelSize: 11
                leftPadding: 20
                rightPadding: 20
            }
        }
    }

    // Elegant exit fade animation
    NumberAnimation {
        id: fadeOutOnboardingAnim
        target: onboardingRoot
        property: "opacity"
        to: 0.0
        duration: 400
        easing.type: Easing.InOutQuad
        onFinished: {
            onboardingRoot.completed()
        }
    }
}
