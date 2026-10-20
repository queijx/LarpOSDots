import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

PanelWindow {
    anchors {
        top: false
        left: true
        right: true
        bottom: true
    }


    implicitHeight: 20
    color: "transparent"

    Rectangle{
        anchors.fill: parent

        color: "#000000"
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }        

    Row {
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }

        spacing: 0

        Rectangle {
            width: timeText.contentWidth + 12
            height: 20
            color: "#000000"
            anchors.verticalCenter: parent.verticalCenter

            Text {
                id: timeText
                anchors.centerIn: parent

                text: Qt.formatDateTime(clock.date, "hh:mm")
                font.family: 'BigBlueTermPlus Nerd Font Mono'
                color: "#ffffff"

                font.pixelSize: 14
                
            }
        }

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: volumeText.contentWidth + 10
            height: 20
            color: '#ff0000'
            
            Text {
                id: volumeText
                anchors.centerIn: parent
                
                font.family: 'BigBlueTermPlus Nerd Font Mono'
                font.pixelSize: 14
                color: "#ffffff"

                text: "50% "
            }

            Process {
                id: volProcess

                command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
                running: true

                stdout: StdioCollector {
                    onStreamFinished: {
                        let output = this.text.trim();
                        if (output.includes("Volume:")) {
                            let parts = output.split(" ");
                            let volFloat = parseFloat(parts[1]);
                            let volPercent = Math.round(volFloat * 100);
                            let isMuted = output.includes("MUTED");

                            volumeText.text = isMuted ? volPercent + "% 󰖁" : volPercent + "% 󰕾"
                        }
                    }
                }
            }

            Timer {
                interval: 28
                running: true
                repeat: true
                onTriggered: {
                    volProcess.running = true;
                }
            }
        }

        Repeater {
            model: SystemTray.items

            delegate: Item {
                width: 20
                height: 20

                Image {
                    anchors.fill: parent
                    source: modelData.icon || ""
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    onClicked: mouse => {
                        if (mouse.button === Qt.LeftButton) {
                            modelData.activate()
                        } else if (mouse.button === Qt.RightButton) {
                            if (modelData.hasMenu) {
                                modelData.menu.open()
                            } else {
                                modelData.secondaryActivate()
                            }
                        }
                    }
                }
            }
        }
    }

    Row {
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }

        spacing: 0

        Repeater {
            model: Hyprland.workspaces

            delegate: Rectangle {
                width: wsText.contentWidth + 10
                height: 20

                color: modelData.active ? "#8000ff" : "#00ffff"

                Text {
                    id: wsText
                    anchors.centerIn: parent
                    
                    font.family: 'BigBlueTermPlus Nerd Font Mono'
                    font.pixelSize: 14
                    color: modelData.active ? "#ffffff" : "#8000ff"

                    text: modelData.name

                    
                }
            }
        }

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: osLogo.contentWidth + 7
            height: 20
            color: '#ffffff'

            Text {
                id: osLogo
                anchors.centerIn: parent

                font.family: 'BigBlueTermPlus Nerd Font Mono'
                font.pixelSize: 14
                color: "#000000"

                text: "queijolgkboom"
            }
        }
    }
}