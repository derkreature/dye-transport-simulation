TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

QMAKE_CXXFLAGS += -fopenmp
QMAKE_CXXFLAGS_RELEASE -= -O2
QMAKE_CXXFLAGS_RELEASE += -O3

SOURCES += \
    src/main.cpp \
    src/fluid-sim/math.cpp \
    src/fluid-sim/fluidsystem.cpp \
    src/graphics/shader.cpp \
    src/graphics/fluidtexture.cpp \
    src/graphics/resourcemanager.cpp \
    src/graphics/canvas.cpp \
    src/graphics/interface.cpp \
    src/graphics/fluidmanipulator.cpp

HEADERS += \
    src/fluid-sim/math.h \
    src/fluid-sim/vectorfield.h \
    src/fluid-sim/vectorfield.tpp \
    src/fluid-sim/fluidsystem.h \
    src/fluid-sim/fluidsystem.tpp \
    src/graphics/shader.h \
    src/graphics/fluidtexture.h \
    src/graphics/canvas.h \
    src/graphics/resourcemanager.h \
    src/graphics/interface.h \
    src/graphics/fluidmanipulator.h

DISTFILES += \
    src/graphics/canvas.frag \
    src/graphics/canvas.vert

shaders.path = $${OUT_PWD}/shaders
shaders.files += \
    src/graphics/canvas.frag \
    src/graphics/canvas.vert
INSTALLS += shaders

INCLUDEPATH += ext/eigen3.3b2 ext/glm-0.9.7.6

LIBS += -fopenmp -lGL -lGLEW -lglfw
