{ mkDerivation
, cmake
, fetchurl
, gettext
, gst_all_1
, lib
, ninja
, qmlbox2d
, qtbase
, qtdeclarative
, qtgraphicaleffects
, qtmultimedia
, qtquickcontrols
, qtsensors
, qttools
, qtxmlpatterns
}:

mkDerivation rec {
  pname = "gcompris";
  version = "1.0";

  src = fetchurl {
    url = "http://gcompris.net/download/qt/src/gcompris-qt-${version}.tar.xz";
    sha256 = "08dw1q0h4qz2q0ksa5pbmb9v60hr1zv9skx6z8dlq9b1i7harnds";
  };

  cmakeFlags = [
    "-DQML_BOX2D_LIBRARY=${qmlbox2d}/${qtbase.qtQmlPrefix}/Box2D.2.0"
  ];

  nativeBuildInputs = [ cmake gettext ninja qttools ];

  buildInputs = [
    qmlbox2d
    qtbase
    qtdeclarative
    qtgraphicaleffects
    qtmultimedia
    qtquickcontrols
    qtsensors
    qtxmlpatterns
  ] ++ (with gst_all_1; [
    gstreamer
    gst-plugins-base
    gst-plugins-good
    gst-plugins-bad
  ]);

  postInstall = ''
    install -Dm444 ../org.kde.gcompris.desktop        $out/share/applications/gcompris.desktop
    install -Dm444 ../images/256-apps-gcompris-qt.png $out/share/icons/hicolor/256x256/apps/gcompris-qt.png
    install -Dm444 ../org.kde.gcompris.appdata.xml -t $out/share/metainfo

    qtWrapperArgs+=(--prefix GST_PLUGIN_SYSTEM_PATH_1_0 : "$GST_PLUGIN_SYSTEM_PATH_1_0")
  '';

  meta = with lib; {
    description = "A high quality educational software suite, including a large number of activities for children aged 2 to 10";
    homepage = "https://gcompris.net/";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ guibou ];
    platforms = platforms.linux;
  };
}
