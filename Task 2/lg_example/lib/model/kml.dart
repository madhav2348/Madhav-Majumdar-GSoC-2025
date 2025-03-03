class KML {
String name;
  String content;
  String id;
  

  KML( this.name,{  required this.content ,required this.id} );

   String get fileKML {
    return '''
<?xml version="1.0" encoding="UTF-8"?>
  <kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
    <Document id="$id">
    <Style id="transPurpleLineGreenPoly">
      <LineStyle>
        <color>7fff00ff</color>
        <width>4</width>
      </LineStyle>
      <PolyStyle>
        <color>7f00ff00</color>
      </PolyStyle>
    </Style>
    <Style id="yellowLineGreenPoly">
      <LineStyle>
        <color>7f00ffff</color>
        <width>4</width>
      </LineStyle>
      <PolyStyle>
        <color>7f00ff00</color>
      </PolyStyle>
    </Style>
    <Style id="thickBlackLine">
      <LineStyle>
        <color>87000000</color>
        <width>10</width>
      </LineStyle>
    </Style>
    <Style id="redLineBluePoly">
      <LineStyle>
        <color>ff0000ff</color>
      </LineStyle>
      <PolyStyle>
        <color>ffff0000</color>
      </PolyStyle>
    </Style>
    <Style id="blueLineRedPoly">
      <LineStyle>
        <color>ffff0000</color>
      </LineStyle>
      <PolyStyle>
        <color>ff0000ff</color>
      </PolyStyle>
    </Style>
    <Style id="transRedPoly">
      <LineStyle>
        <width>1.5</width>
      </LineStyle>
      <PolyStyle>
        <color>7d0000ff</color>
      </PolyStyle>
    </Style>
    <Style id="transBluePoly">
      <LineStyle>
        <width>1.5</width>
      </LineStyle>
      <PolyStyle>
        <color>7dff0000</color>
      </PolyStyle>
    </Style>
    <Style id="transGreenPoly">
      <LineStyle>
        <width>1.5</width>
      </LineStyle>
      <PolyStyle>
        <color>7d00ff00</color>
      </PolyStyle>
    </Style>
    <Style id="transYellowPoly">
      <LineStyle>
        <width>1.5</width>
      </LineStyle>
      <PolyStyle>
        <color>7d00ffff</color>
      </PolyStyle>
    </Style>
    <Style id="transYellowPoly">
      <LineStyle>
        <width>1.5</width>
      </LineStyle>
      <PolyStyle>
        <color>7d00f0f0</color>
      </PolyStyle>
    </Style>
          <name>Network Links</name>
          <visibility>1</visibility>
          <description>Network Example</description>
      <name>$name</name>
        $content
    </Document>
  </kml>
''';
  }
}
