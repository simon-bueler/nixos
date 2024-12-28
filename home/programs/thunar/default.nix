{ pkgs, ... }: {
  # ctrl + m to toggle the menubar
  home.packages = with pkgs.xfce; [
    thunar
    xfconf
    tumbler
    thunar-archive-plugin
    thunar-volman
  ];

  # View settings
  home.file.".config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml".text = ''
  <?xml version="1.0" encoding="UTF-8"?>

  <channel name="thunar" version="1.0">
    <property name="last-view" type="string" value="ThunarDetailsView"/>
    <property name="last-icon-view-zoom-level" type="string" value="THUNAR_ZOOM_LEVEL_100_PERCENT"/>
    <property name="last-window-maximized" type="bool" value="true"/>
    <property name="last-separator-position" type="int" value="170"/>
    <property name="last-statusbar-visible" type="bool" value="false"/>
    <property name="last-menubar-visible" type="bool" value="true"/>
    <property name="misc-single-click" type="bool" value="false"/>
    <property name="shortcuts-icon-emblems" type="bool" value="true"/>
    <property name="tree-icon-emblems" type="bool" value="true"/>
    <property name="misc-file-size-binary" type="bool" value="true"/>
    <property name="misc-thumbnail-draw-frames" type="bool" value="false"/>
    <property name="misc-text-beside-icons" type="bool" value="true"/>
    <property name="misc-change-window-icon" type="bool" value="true"/>
    <property name="hidden-bookmarks" type="array">
      <value type="string" value="computer:///"/>
      <value type="string" value="recent:///"/>
      <value type="string" value="file:///"/>
      <value type="string" value="network:///"/>
    </property>
    <property name="hidden-devices" type="array">
      <value type="string" value="52FEA905FEA8E309"/>
    </property>
    <property name="last-toolbar-item-order" type="string" value="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17"/>
    <property name="last-toolbar-visible-buttons" type="string" value="0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0"/>
    <property name="last-location-bar" type="string" value="ThunarLocationButtons"/>
    <property name="last-show-hidden" type="bool" value="true"/>
    <property name="last-details-view-zoom-level" type="string" value="THUNAR_ZOOM_LEVEL_38_PERCENT"/>
    <property name="last-details-view-column-widths" type="string" value="50,50,162,50,50,50,50,50,175,50,50,81,50,936"/>
    <property name="last-details-view-column-order" type="string" value="THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_DATE_MODIFIED,THUNAR_COLUMN_SIZE_IN_BYTES,THUNAR_COLUMN_TYPE,THUNAR_COLUMN_LOCATION,THUNAR_COLUMN_GROUP,THUNAR_COLUMN_MIME_TYPE,THUNAR_COLUMN_DATE_CREATED,THUNAR_COLUMN_OWNER,THUNAR_COLUMN_PERMISSIONS,THUNAR_COLUMN_DATE_ACCESSED,THUNAR_COLUMN_RECENCY,THUNAR_COLUMN_DATE_DELETED"/>
  </channel>
  '';
  home.file.".config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml".force = true;

  #custom action settings > change Terminal for open in Terminal option
  home.file.".config/Thunar/uca.xml".text = ''
  <?xml version="1.0" encoding="UTF-8"?>
  <actions>
  <action>
      <icon>utilities-terminal</icon>
      <name>Terminal hier öffnen</name>
      <submenu></submenu>
      <unique-id>1730569995126542-1</unique-id>
      <command>kitty %f</command>
      <description>Beispiel für eine eigene Aktion</description>
      <range></range>
      <patterns>*</patterns>
      <startup-notify/>
      <directories/>
  </action>
  </actions>
  '';
  home.file.".config/Thunar/uca.xml".force = true;

}
