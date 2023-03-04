import QtQuick 2.15
import QtQuick.Controls 2.15

Row {
	property string icon
	property alias model: _combo.model
	property string textRole

	spacing: 10;

	ComboBox {
		id: _combo
		textRole: parent.textRole
		flat: true

		bottomPadding: 10
		leftPadding: 15
		topPadding: 10
		
		background: Rectangle {
			color: parent.activeFocus ? config.color_overlay : config.color_base
		}

		contentItem: Text {
			id: _content
			text: _combo.displayText

			font.family: font_text.name
			font.pointSize: 14
			color: config.color_text

			horizontalAlignment: Text.Right
			verticalAlignment: Text.AlignVCenter
		}

		delegate: ItemDelegate {
			contentItem: Text {
				text: Array.isArray(_combo.model)
					? modelData[_combo.textRole]
					: model[_combo.textRole]

				font: _content.font
				color: _content.color
				horizontalAlignment: Text.AlignHCenter
			}
			background: Rectangle {
				color: config.color_surface
			}
			width: parent.width
		}
		anchors.verticalCenter: parent.verticalCenter
	}

	TextIcon {
		text: parent.icon
	}
}
