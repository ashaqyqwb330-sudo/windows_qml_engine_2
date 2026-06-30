import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "transparent"

    // Theme references (matching main.qml)
    readonly property color slateBg: "#0B0F19"
    readonly property color cardSlateBg: "#161D2C"
    readonly property color borderSlate: "#212A3E"
    readonly property color metallicGold: "#D4AF37"
    readonly property color softGold: "#F3E5AB"
    readonly property color textSilver: "#E2E8F0"
    readonly property color textGray: "#808A9D"
    readonly property color successGreen: "#10B981"
    readonly property color errorRed: "#EF4444"

    // Bilingual translations
    function getTxt(key) {
        var translations = {
            "title": { "ar": "🎨 بنك الأنماط والتصاميم المخصصة Pro", "en": "🎨 Custom Style & Design Bank Pro" },
            "desc": { "ar": "إدارة كاملة لأنماط CSS المخصصة وقوالب التصميم، مع إمكانية البحث الفوري، التصنيف، الإضافة، الحذف، والنسخ السريع لتصميم مستنداتك.", "en": "Comprehensive CSS design repository. Copy, apply, and manage custom visual styling snippets for your notes and code exports." },
            "search_placeholder": { "ar": "🔍 ابحث باسم النمط، المحدد، أو قواعد CSS...", "en": "🔍 Search by style name, selector, or CSS code..." },
            "add_style": { "ar": "✨ إضافة نمط جديد", "en": "✨ Add New Style" },
            "no_styles": { "ar": "⚠️ لا توجد أنماط مطابقة لمعايير البحث والتصنيف الحالية.", "en": "⚠️ No styles match the current search or category filter." },
            
            // Dialog
            "dialog_title": { "ar": "✨ إضافة تصميم ونمط جديد للبنك", "en": "✨ Add New Style Template" },
            "lbl_name": { "ar": "اسم النمط / التصميم:", "en": "Style Name:" },
            "lbl_selector": { "ar": "محدد الـ CSS (Selector) - اختياري:", "en": "CSS Selector (Optional):" },
            "lbl_css": { "ar": "قواعد الـ CSS (Rules):", "en": "CSS Rules:" },
            "lbl_category": { "ar": "الفئة / القسم:", "en": "Category:" },
            "btn_save": { "ar": "حفظ النمط 💾", "en": "Save Style 💾" },
            "btn_cancel": { "ar": "إلغاء ❌", "en": "Cancel ❌" },
            
            // Success/Error alerts
            "err_empty": { "ar": "يرجى تعبئة الحقول المطلوبة (الاسم وقواعد CSS).", "en": "Please fill in the required fields (Name and CSS rules)." },
            "success_add": { "ar": "تم إضافة التصميم بنجاح!", "en": "Style template added successfully!" },
            "success_delete": { "ar": "تم حذف التصميم بنجاح!", "en": "Style template deleted successfully!" },
            "success_apply": { "ar": "تم تطبيق النمط المخصص كإعداد افتراضي للتصميم!", "en": "Custom style applied as default template CSS!" },
            "success_copy": { "ar": "تم نسخ قواعد النمط للحافظة بنجاح!", "en": "Style CSS copied to clipboard successfully!" },
            
            // Delete Dialog
            "delete_confirm": { "ar": "هل أنت متأكد من رغبتك في حذف هذا النمط؟", "en": "Are you sure you want to delete this style template?" },
            "delete_title": { "ar": "تأكيد الحذف ❌", "en": "Confirm Deletion ❌" },
            "yes": { "ar": "نعم، احذف", "en": "Yes, Delete" },
            "no": { "ar": "إلغاء", "en": "Cancel" }
        };
        var isAr = (backend.appLanguage === "ar");
        return translations[key] ? (isAr ? translations[key]["ar"] : translations[key]["en"]) : "";
    }

    property string searchQuery: ""
    property string activeCategory: "all" // "all", "buttons", "cards", "texts", "general"

    ListModel {
        id: localFilteredModel
    }

    // Load and filter local styles model
    function applyFilter() {
        localFilteredModel.clear()
        
        // Ensure stylesModel exists
        if (typeof stylesModel === "undefined" || stylesModel === null) return;

        for (var i = 0; i < stylesModel.count; i++) {
            var item = stylesModel.get(i);
            if (!item) continue;
            
            var cat = (item.category || "عام").trim().toLowerCase();
            var name = (item.name || "").toLowerCase();
            var sel = (item.selector || "").toLowerCase();
            var css = (item.css_code || "").toLowerCase();
            var query = searchQuery.toLowerCase().trim();

            // Category Filter
            var matchesCategory = false;
            if (activeCategory === "all") {
                matchesCategory = true;
            } else if (activeCategory === "buttons") {
                matchesCategory = (cat === "أزرار" || cat === "buttons" || cat === "button" || cat === "styles_button");
            } else if (activeCategory === "cards") {
                matchesCategory = (cat === "بطاقات" || cat === "cards" || cat === "card" || cat === "styles_card");
            } else if (activeCategory === "texts") {
                matchesCategory = (cat === "نصوص" || cat === "texts" || cat === "text" || cat === "styles_text");
            } else if (activeCategory === "general") {
                matchesCategory = (cat === "عام" || cat === "general" || cat === "other" || cat === "" || cat === "general_style");
            }

            // Search Query Filter
            var matchesQuery = (query === "") || 
                               (name.indexOf(query) !== -1) || 
                               (sel.indexOf(query) !== -1) || 
                               (css.indexOf(query) !== -1);

            if (matchesCategory && matchesQuery) {
                localFilteredModel.append({
                    "name": item.name,
                    "css_code": item.css_code,
                    "selector": item.selector || "",
                    "category": item.category || "عام",
                    "created_at": item.created_at || ""
                });
            }
        }
    }

    onSearchQueryChanged: applyFilter()
    onActiveCategoryChanged: applyFilter()

    Connections {
        target: backend
        function onDbUpdated() {
            timerDelay.start()
        }
    }

    Timer {
        id: timerDelay
        interval: 100
        repeat: false
        onTriggered: applyFilter()
    }

    Component.onCompleted: applyFilter()

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        // Header Section
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 4

            Text {
                text: root.getTxt("title")
                color: metallicGold
                font.bold: true
                font.pixelSize: 18
            }

            Text {
                text: root.getTxt("desc")
                color: textGray
                font.pixelSize: 11
                wrapMode: Text.Wrap
                Layout.fillWidth: true
            }
        }

        // Search & Control Bar
        Rectangle {
            Layout.fillWidth: true
            height: 48
            color: cardSlateBg
            border.color: borderSlate
            radius: 8

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                spacing: 10

                TextField {
                    id: searchInput
                    placeholderText: root.getTxt("search_placeholder")
                    color: textSilver
                    font.pixelSize: 11
                    Layout.fillWidth: true
                    background: null
                    onTextChanged: root.searchQuery = text
                    selectByMouse: true
                }
                
                // Clear search button if active
                Button {
                    text: "❌"
                    visible: searchInput.text !== ""
                    implicitWidth: 24
                    implicitHeight: 24
                    background: null
                    onClicked: {
                        searchInput.text = ""
                    }
                }
            }
        }

        // Category Selector Pills
        RowLayout {
            Layout.fillWidth: true
            spacing: 8
            
            // Category Buttons Repeater
            Repeater {
                model: [
                    { "key": "all", "ar": "الكل 🌐", "en": "All 🌐" },
                    { "key": "buttons", "ar": "أزرار 🔘", "en": "Buttons 🔘" },
                    { "key": "cards", "ar": "بطاقات 🎴", "en": "Cards 🎴" },
                    { "key": "texts", "ar": "نصوص 📝", "en": "Texts 📝" },
                    { "key": "general", "ar": "عام ⚙️", "en": "General ⚙️" }
                ]
                
                Button {
                    id: filterBtn
                    text: backend.appLanguage === "ar" ? modelData.ar : modelData.en
                    implicitHeight: 28
                    checkable: true
                    checked: root.activeCategory === modelData.key
                    onClicked: root.activeCategory = modelData.key
                    
                    background: Rectangle {
                        color: filterBtn.checked ? borderSlate : "transparent"
                        border.color: filterBtn.checked ? metallicGold : borderSlate
                        border.width: 1
                        radius: 14
                    }
                    contentItem: Text {
                        text: filterBtn.text
                        color: filterBtn.checked ? metallicGold : textSilver
                        font.bold: true
                        font.pixelSize: 11
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
            
            Spacer { Layout.fillWidth: true }
            
            // Add Style Button
            Button {
                id: addBtn
                text: root.getTxt("add_style")
                implicitHeight: 28
                onClicked: addStyleDialog.open()
                
                background: Rectangle {
                    color: "#1E295D"
                    border.color: metallicGold
                    border.width: 1
                    radius: 14
                }
                contentItem: Text {
                    text: addBtn.text
                    color: metallicGold
                    font.bold: true
                    font.pixelSize: 11
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 10
                    rightPadding: 10
                }
            }
        }

        // Styles List View Card
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"
            
            ScrollView {
                anchors.fill: parent
                clip: true
                
                ListView {
                    id: stylesListView
                    model: localFilteredModel
                    spacing: 12
                    
                    // Empty list indicator
                    Text {
                        anchors.centerIn: parent
                        text: root.getTxt("no_styles")
                        color: textGray
                        font.pixelSize: 12
                        visible: localFilteredModel.count === 0
                    }
                    
                    delegate: Rectangle {
                        width: stylesListView.width - 15
                        height: 155
                        color: cardSlateBg
                        border.color: borderSlate
                        radius: 8
                        
                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 15
                            
                            // Left Side: Meta & Code View
                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                spacing: 6
                                
                                RowLayout {
                                    spacing: 8
                                    Text {
                                        text: model.name
                                        color: metallicGold
                                        font.bold: true
                                        font.pixelSize: 13
                                        elide: Text.ElideRight
                                        Layout.fillWidth: true
                                    }
                                    
                                    // Category Badge
                                    Rectangle {
                                        implicitWidth: 65
                                        implicitHeight: 18
                                        color: borderSlate
                                        radius: 4
                                        border.color: metallicGold
                                        border.width: 0.5
                                        Text {
                                            anchors.centerIn: parent
                                            text: model.category
                                            color: metallicGold
                                            font.pixelSize: 9
                                            font.bold: true
                                        }
                                    }
                                }
                                
                                // Selector Row
                                RowLayout {
                                    spacing: 4
                                    Text {
                                        text: "Selector: "
                                        color: textGray
                                        font.pixelSize: 10
                                    }
                                    Text {
                                        text: model.selector || "N/A"
                                        color: "#38BDF8"
                                        font.family: "Consolas"
                                        font.pixelSize: 10
                                        font.bold: true
                                        elide: Text.ElideRight
                                        Layout.fillWidth: true
                                    }
                                }
                                
                                // CSS Code Block Container
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    color: slateBg
                                    border.color: borderSlate
                                    radius: 6
                                    
                                    ScrollView {
                                        anchors.fill: parent
                                        anchors.margins: 6
                                        clip: true
                                        
                                        Text {
                                            text: model.css_code
                                            color: textSilver
                                            font.family: "Consolas"
                                            font.pixelSize: 10
                                            wrapMode: Text.WrapAnywhere
                                            width: parent.width
                                        }
                                    }
                                }
                                
                                // Date string
                                Text {
                                    text: model.created_at || ""
                                    color: textGray
                                    font.pixelSize: 9
                                }
                            }
                            
                            // Right Side: Quick Actions Column
                            ColumnLayout {
                                Layout.preferredWidth: 90
                                spacing: 8
                                Layout.alignment: Qt.AlignVCenter
                                
                                // Copy Button
                                Button {
                                    id: btnCopy
                                    text: backend.appLanguage === "ar" ? "نسخ 📋" : "Copy 📋"
                                    Layout.fillWidth: true
                                    implicitHeight: 28
                                    onClicked: {
                                        var cssToCopy = model.selector ? model.selector + " {\n" + model.css_code + "\n}" : model.css_code;
                                        backend.set_clipboard_text(cssToCopy);
                                        toastBox.trigger("Style Bank", root.getTxt("success_copy"), "success");
                                    }
                                    background: Rectangle {
                                        color: btnCopy.down ? "#1B2333" : (btnCopy.hovered ? "#2E3C54" : "transparent")
                                        border.color: metallicGold
                                        border.width: 1
                                        radius: 4
                                    }
                                    contentItem: Text {
                                        text: btnCopy.text
                                        color: metallicGold
                                        font.bold: true
                                        font.pixelSize: 11
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                }
                                
                                // Apply Button
                                Button {
                                    id: btnApply
                                    text: backend.appLanguage === "ar" ? "تطبيق ⚡" : "Apply ⚡"
                                    Layout.fillWidth: true
                                    implicitHeight: 28
                                    onClicked: {
                                        var cssToApply = model.selector ? model.selector + " {\n" + model.css_code + "\n}" : model.css_code;
                                        backend.set_setting("smart_capture_custom_css", cssToApply);
                                        toastBox.trigger("Style Bank", root.getTxt("success_apply"), "success");
                                    }
                                    background: Rectangle {
                                        color: btnApply.down ? "#1B2333" : (btnApply.hovered ? "#12251D" : "transparent")
                                        border.color: successGreen
                                        border.width: 1
                                        radius: 4
                                    }
                                    contentItem: Text {
                                        text: btnApply.text
                                        color: successGreen
                                        font.bold: true
                                        font.pixelSize: 11
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                }
                                
                                // Delete Button
                                Button {
                                    id: btnDel
                                    text: backend.appLanguage === "ar" ? "حذف ❌" : "Delete ❌"
                                    Layout.fillWidth: true
                                    implicitHeight: 28
                                    onClicked: {
                                        styleToDeleteName = model.name;
                                        deleteConfirmDialog.open();
                                    }
                                    background: Rectangle {
                                        color: btnDel.down ? "#1B2333" : (btnDel.hovered ? "#21050E" : "transparent")
                                        border.color: errorRed
                                        border.width: 1
                                        radius: 4
                                    }
                                    contentItem: Text {
                                        text: btnDel.text
                                        color: errorRed
                                        font.bold: true
                                        font.pixelSize: 11
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Modal Confirmation Dialog for Deletion
    property string styleToDeleteName: ""
    Dialog {
        id: deleteConfirmDialog
        title: root.getTxt("delete_title")
        anchors.centerIn: parent
        width: 320
        modal: true
        
        background: Rectangle {
            color: cardSlateBg
            border.color: borderSlate
            radius: 8
        }
        
        header: Rectangle {
            width: parent.width
            height: 36
            color: borderSlate
            radius: 8
            Text {
                anchors.centerIn: parent
                text: deleteConfirmDialog.title
                color: errorRed
                font.bold: true
                font.pixelSize: 12
            }
        }
        
        contentItem: Text {
            text: root.getTxt("delete_confirm") + "\n\n(" + styleToDeleteName + ")"
            color: textSilver
            font.pixelSize: 11
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
        }
        
        footer: RowLayout {
            spacing: 12
            Layout.margins: 10
            anchors.horizontalCenter: parent.horizontalCenter
            height: 48
            
            Button {
                id: confirmDelBtn
                text: root.getTxt("yes")
                implicitWidth: 100
                implicitHeight: 30
                onClicked: {
                    backend.delete_style(styleToDeleteName);
                    toastBox.trigger("Style Bank", root.getTxt("success_delete"), "info");
                    deleteConfirmDialog.close();
                }
                background: Rectangle {
                    color: confirmDelBtn.hovered ? "#3F1B22" : "#21050E"
                    border.color: errorRed
                    border.width: 1
                    radius: 4
                }
                contentItem: Text {
                    text: confirmDelBtn.text
                    color: errorRed
                    font.bold: true
                    font.pixelSize: 11
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Button {
                id: cancelDelBtn
                text: root.getTxt("no")
                implicitWidth: 100
                implicitHeight: 30
                onClicked: deleteConfirmDialog.close()
                background: Rectangle {
                    color: "transparent"
                    border.color: borderSlate
                    border.width: 1
                    radius: 4
                }
                contentItem: Text {
                    text: cancelDelBtn.text
                    color: textSilver
                    font.bold: true
                    font.pixelSize: 11
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }

    // Modal Dialog for adding a new Style
    Dialog {
        id: addStyleDialog
        title: root.getTxt("dialog_title")
        anchors.centerIn: parent
        width: 480
        height: 440
        modal: true
        
        background: Rectangle {
            color: cardSlateBg
            border.color: borderSlate
            radius: 8
        }
        
        header: Rectangle {
            width: parent.width
            height: 45
            color: borderSlate
            radius: 8
            Text {
                anchors.centerIn: parent
                text: addStyleDialog.title
                color: metallicGold
                font.bold: true
                font.pixelSize: 13
            }
        }
        
        contentItem: ColumnLayout {
            spacing: 12
            anchors.margins: 12
            
            // Name Input
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4
                Text { text: root.getTxt("lbl_name"); color: metallicGold; font.pixelSize: 11; font.bold: true }
                Rectangle {
                    Layout.fillWidth: true
                    height: 36
                    color: slateBg
                    border.color: borderSlate
                    radius: 6
                    TextField {
                        id: txtName
                        anchors.fill: parent
                        anchors.leftMargin: 8
                        anchors.rightMargin: 8
                        color: textSilver
                        font.pixelSize: 11
                        background: null
                        selectByMouse: true
                    }
                }
            }
            
            // Selector Input
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4
                Text { text: root.getTxt("lbl_selector"); color: metallicGold; font.pixelSize: 11; font.bold: true }
                Rectangle {
                    Layout.fillWidth: true
                    height: 36
                    color: slateBg
                    border.color: borderSlate
                    radius: 6
                    TextField {
                        id: txtSelector
                        anchors.fill: parent
                        anchors.leftMargin: 8
                        anchors.rightMargin: 8
                        color: textSilver
                        placeholderText: ".my-custom-style-class"
                        font.family: "Consolas"
                        font.pixelSize: 11
                        background: null
                        selectByMouse: true
                    }
                }
            }
            
            // Category Select
            RowLayout {
                Layout.fillWidth: true
                spacing: 10
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 4
                    Text { text: root.getTxt("lbl_category"); color: metallicGold; font.pixelSize: 11; font.bold: true }
                    ComboBox {
                        id: comboCategory
                        Layout.fillWidth: true
                        model: backend.appLanguage === "ar" ? ["عام", "أزرار", "بطاقات", "نصوص"] : ["General", "Buttons", "Cards", "Texts"]
                    }
                }
            }
            
            // CSS Code TextArea
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 4
                Text { text: root.getTxt("lbl_css"); color: metallicGold; font.pixelSize: 11; font.bold: true }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: slateBg
                    border.color: borderSlate
                    radius: 6
                    
                    ScrollView {
                        anchors.fill: parent
                        anchors.margins: 6
                        TextArea {
                            id: txtCssCode
                            color: textSilver
                            font.family: "Consolas"
                            font.pixelSize: 11
                            placeholderText: "background-color: #2e3c54;\nborder-radius: 8px;\npadding: 10px;"
                            selectByMouse: true
                            wrapMode: TextEdit.Wrap
                            background: null
                        }
                    }
                }
            }
        }
        
        footer: RowLayout {
            spacing: 15
            Layout.margins: 12
            anchors.horizontalCenter: parent.horizontalCenter
            height: 50
            
            Button {
                id: btnSave
                text: root.getTxt("btn_save")
                implicitWidth: 120
                implicitHeight: 32
                onClicked: {
                    var nameVal = txtName.text.trim();
                    var cssVal = txtCssCode.text.trim();
                    var selVal = txtSelector.text.trim();
                    var catVal = comboCategory.currentText;
                    
                    if (nameVal === "" || cssVal === "") {
                        toastBox.trigger("Style Bank", root.getTxt("err_empty"), "error");
                        return;
                    }
                    
                    // Map English combo values back to standard Arabic keys for internal filter compatibility if language is English
                    var dbCatVal = catVal;
                    if (backend.appLanguage !== "ar") {
                        if (catVal === "Buttons") dbCatVal = "أزرار";
                        else if (catVal === "Cards") dbCatVal = "بطاقات";
                        else if (catVal === "Texts") dbCatVal = "نصوص";
                        else dbCatVal = "عام";
                    }
                    
                    // Save Style via backend
                    backend.add_style(nameVal, cssVal, selVal, dbCatVal);
                    toastBox.trigger("Style Bank", root.getTxt("success_add"), "success");
                    
                    // Clear fields and close
                    txtName.text = "";
                    txtCssCode.text = "";
                    txtSelector.text = "";
                    addStyleDialog.close();
                }
                background: Rectangle {
                    color: btnSave.hovered ? "#1E3A8A" : "#1E295D"
                    border.color: metallicGold
                    border.width: 1
                    radius: 6
                }
                contentItem: Text {
                    text: btnSave.text
                    color: metallicGold
                    font.bold: true
                    font.pixelSize: 11
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            
            Button {
                id: btnCancel
                text: root.getTxt("btn_cancel")
                implicitWidth: 120
                implicitHeight: 32
                onClicked: {
                    txtName.text = "";
                    txtCssCode.text = "";
                    txtSelector.text = "";
                    addStyleDialog.close();
                }
                background: Rectangle {
                    color: "transparent"
                    border.color: borderSlate
                    border.width: 1
                    radius: 6
                }
                contentItem: Text {
                    text: btnCancel.text
                    color: textSilver
                    font.bold: true
                    font.pixelSize: 11
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
}
