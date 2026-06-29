import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: splashRoot
    anchors.fill: parent
    color: "#05070E" // Dark golden-slate background

    // Theme references matching main.qml
    readonly property color slateBg: "#05070E"
    readonly property color cardSlateBg: "#0D1127"
    readonly property color borderSlate: "#1E295D"
    readonly property color metallicGold: "#FCD34D"
    readonly property color softGold: "#FDE047"
    readonly property color textSilver: "#E4E9FC"
    readonly property color textGray: "#64748B"

    signal finished()

    // Background Gradient for a premium cinematic feel
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#030408" }
        GradientStop { position: 0.5; color: "#0B0F19" }
        GradientStop { position: 1.0; color: "#161D2C" }
    }

    // Main Content Column
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 25
        horizontalAlignment: Text.AlignHCenter

        // Glowing Logo Container
        Item {
            Layout.preferredWidth: 160
            Layout.preferredHeight: 160
            Layout.alignment: Qt.AlignHCenter

            // Outer glowing radial ring
            Rectangle {
                id: glowRing
                anchors.fill: parent
                radius: width / 2
                color: "transparent"
                border.color: metallicGold
                border.width: 2
                opacity: 0.4
                scale: 1.0

                // Continuous pulse scale animation
                SequentialAnimation on scale {
                    loops: Animation.Infinite
                    NumberAnimation { from: 0.95; to: 1.1; duration: 1500; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: 1.1; to: 0.95; duration: 1500; easing.type: Easing.InOutQuad }
                }

                // Smooth glow effect with thin border
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: -6
                    radius: width / 2
                    color: "transparent"
                    border.color: softGold
                    border.width: 1
                    opacity: 0.2
                    scale: glowRing.scale
                }
            }

            // Inner Rotating Circle with the Icon
            Rectangle {
                id: innerCircle
                anchors.centerIn: parent
                width: 120
                height: 120
                radius: 60
                color: "#161D2C"
                border.color: borderSlate
                border.width: 2

                // Gradient interior
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#1F2937" }
                    GradientStop { position: 1.0; color: "#111827" }
                }

                // Rotating Crown Icon
                Text {
                    id: logoText
                    text: "👑"
                    font.pixelSize: 58
                    anchors.centerIn: parent
                    transformOrigin: Item.Center

                    // Continuous subtle rotation animation
                    SequentialAnimation on rotation {
                        loops: Animation.Infinite
                        NumberAnimation { from: -15; to: 15; duration: 2000; easing.type: Easing.InOutSine }
                        NumberAnimation { from: 15; to: -15; duration: 2000; easing.type: Easing.InOutSine }
                    }

                    // Continuous scale pulse
                    SequentialAnimation on scale {
                        loops: Animation.Infinite
                        NumberAnimation { from: 0.9; to: 1.1; duration: 1500; easing.type: Easing.InOutQuad }
                        NumberAnimation { from: 1.1; to: 0.9; duration: 1500; easing.type: Easing.InOutQuad }
                    }
                }
            }
        }

        // Titles Layout
        ColumnLayout {
            spacing: 8
            Layout.alignment: Qt.AlignHCenter

            // Main Title
            Text {
                text: backend.appLanguage === "ar" ? "المنصة الذهبية الذكية Pro" : "Golden Intelligent Platform Pro"
                color: metallicGold
                font.bold: true
                font.pixelSize: 28
                horizontalAlignment: Text.AlignHCenter
                font.letterSpacing: 1.5
                Layout.alignment: Qt.AlignHCenter

                // Entrance fade-in and scale-up animation
                opacity: 0
                scale: 0.9
                Component.onCompleted: {
                    titleAnim.start()
                }

                ParallelAnimation {
                    id: titleAnim
                    NumberAnimation { target: parent; property: "opacity"; to: 1.0; duration: 1000; easing.type: Easing.OutQuad }
                    NumberAnimation { target: parent; property: "scale"; to: 1.0; duration: 1000; easing.type: Easing.OutBack }
                }
            }

            // Subtitle
            Text {
                text: backend.appLanguage === "ar" ? "مساعد التنظيم والتشغيل الفائق الذكاء" : "Ultra-Intelligent Organization & Execution Assistant"
                color: textSilver
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                opacity: 0

                Component.onCompleted: {
                    subTitleAnim.start()
                }

                NumberAnimation {
                    id: subTitleAnim
                    target: parent
                    property: "opacity"
                    to: 0.8
                    duration: 1000
                    delay: 400
                    easing.type: Easing.OutQuad
                }
            }
        }

        // Loading bar indicator
        Rectangle {
            width: 240
            height: 4
            color: "#1E295D"
            radius: 2
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20

            Rectangle {
                id: progressBar
                height: parent.height
                width: 0
                color: metallicGold
                radius: 2

                PropertyAnimation {
                    target: progressBar
                    property: "width"
                    to: 240
                    duration: 3000
                    easing.type: Easing.InOutQuad
                    running: true
                }
            }
        }
    }

    // Developer Attribution at the Bottom (appears after delay)
    Text {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        text: backend.appLanguage === "ar" ? "تطوير: إدريس يوسف المداني" : "Developed by: Idris Youssef Al-Madani"
        color: textGray
        font.pixelSize: 11
        font.letterSpacing: 1.0
        opacity: 0

        Component.onCompleted: {
            devAnim.start()
        }

        NumberAnimation {
            id: devAnim
            target: parent
            property: "opacity"
            to: 0.6
            duration: 1200
            delay: 1000
            easing.type: Easing.OutQuad
        }
    }

    // Splash timer to close/transition
    Timer {
        id: splashTimer
        interval: 3200
        running: true
        repeat: false
        onTriggered: {
            fadeOutAnim.start()
        }
    }

    // Elegant Fade Out Animation
    NumberAnimation {
        id: fadeOutAnim
        target: splashRoot
        property: "opacity"
        to: 0.0
        duration: 500
        easing.type: Easing.InOutQuad
        onFinished: {
            splashRoot.finished()
        }
    }
}
