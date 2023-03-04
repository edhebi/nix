import QtQuick 2.15

Rectangle {
	id: root
    width: 1920
    height: 1080
	color: config.color_base
	state: "init"

	FontLoader { id: font_text; source: config.font_text }
	FontLoader { id: font_icons; source: config.font_icons }

	Column {
		id: side_menu
		spacing: 10

		anchors {
			top: root.top
			right: root.right
			topMargin: 50
			rightMargin: 50
		}

		DropDown {
			icon: config.icon_session
			model: sessionModel
			textRole: "name"
			anchors.right: side_menu.right
		}

		DropDown {
			icon: config.icon_layout
			model: keyboard.layouts
			textRole: "longName"
			anchors.right: side_menu.right
		}

		TextIcon {>>
			icon: config.icon_reboot
			onClicked: () => sddm.reboot()
			anchors.right: side_menu.right
		}

		TextIcon {
			icon: config.icon_poweroff
			onClicked: () => sddm.powerOff()
			anchors.right: side_menu.right
		}
	}

	
}
