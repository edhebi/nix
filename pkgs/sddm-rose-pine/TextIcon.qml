import QtQuick 2.15

Text {
	signal clicked()
	property string icon

	text: icon
	color: config.color_text
	height: 64
	width: 64
	horizontalAlignment: Text.AlignHCenter
	verticalAlignment: Text.AlignVCenter

	font.family: font_icons.name
	font.pixelSize: _area.containsMouse ? 64 : 56

	MouseArea {
		id: _area
		anchors.fill: parent
		hoverEnabled: true
		onClicked: parent.clicked()
	}

	Behavior on font.pixelSize {
		NumberAnimation { duration: 100; easing.type: Easing.InOutQuad }
	}
}
