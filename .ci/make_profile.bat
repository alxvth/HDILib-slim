conan profile new action_build
conan profile update settings.os=Windows action_build
conan profile update settings.os_build=Windows action_build
conan profile update settings.compiler="Visual Studio" action_build
conan profile update settings.compiler.version=%CONAN_VISUAL_VERSIONS% action_build
