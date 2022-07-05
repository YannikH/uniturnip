import 'dart:async';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

import '../../../../json_schema_ui/models/widget_data.dart';
import 'widget_ui.dart';

// TODO: Refactor FileWidget
class FileWidget extends StatefulWidget {
  const FileWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  _FileWidgetState createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = true;
  FileType _pickingType = FileType.any;
  final TextEditingController _controller = TextEditingController();
  String title = '';
  String description = '';

  @override
  void initState() {
    super.initState();
    title = widget.widgetData.schema['title'] ?? '';
    description = widget.widgetData.schema['description'] ?? '';
    _controller.addListener(() => _extension = _controller.text);
  }

  void _pickFiles() async {
    _resetState();
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
  }

  void _clearCachedFiles() async {
    _resetState();
    try {
      bool? result = await FilePicker.platform.clearTemporaryFiles();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: result! ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveFile() async {
    _resetState();
    try {
      String? fileName = await FilePicker.platform.saveFile(
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
        type: _pickingType,
      );
      setState(() {
        _userAborted = fileName == null;
      });
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _fileName = null;
      _paths = null;
      _userAborted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WidgetUI(
      title: title,
      description: description,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _pickFiles(),
                child: Text(_multiPick ? 'Pick files' : 'Pick file'),
              ),
              ElevatedButton(
                onPressed: () => _saveFile(),
                child: const Text('Save file'),
              ),
              ElevatedButton(
                onPressed: () => _clearCachedFiles(),
                child: const Text('Clear temporary files'),
              ),
            ],
          ),
          Builder(
            builder: (BuildContext context) {
              if (_isLoading) {
                return const CircularProgressIndicator();
              } else if (_userAborted) {
                return const Text('User has aborted the dialog');
              } else if (_paths != null) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) =>
                      Text('File $index: ${_fileName ?? '...'}'),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: _paths!.isNotEmpty ? _paths!.length : 1,
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
