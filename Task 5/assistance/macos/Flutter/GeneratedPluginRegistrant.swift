//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import audio_session
import path_provider_foundation
import record_darwin
import rive_common

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AudioSessionPlugin.register(with: registry.registrar(forPlugin: "AudioSessionPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  RecordPlugin.register(with: registry.registrar(forPlugin: "RecordPlugin"))
  RivePlugin.register(with: registry.registrar(forPlugin: "RivePlugin"))
}
