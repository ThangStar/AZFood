//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <agora_rtc_engine/agora_rtc_engine_plugin.h>
#include <camera_windows/camera_windows.h>
#include <file_selector_windows/file_selector_windows.h>
#include <iris_method_channel/iris_method_channel_plugin_c_api.h>
#include <local_notifier/local_notifier_plugin.h>
#include <video_raw_data/video_raw_data_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  AgoraRtcEnginePluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AgoraRtcEnginePlugin"));
  CameraWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("CameraWindows"));
  FileSelectorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FileSelectorWindows"));
  IrisMethodChannelPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("IrisMethodChannelPluginCApi"));
  LocalNotifierPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("LocalNotifierPlugin"));
  VideoRawDataPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("VideoRawDataPluginCApi"));
}
