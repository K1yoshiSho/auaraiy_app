import 'package:auaraiy/common/constants/theme.dart';
import 'package:auaraiy/common/components/icon_button.dart';
import 'package:auaraiy/common/services/app_state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SearchComponent extends StatefulWidget {
  final Function(String?) onSubmit;

  const SearchComponent({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _SearchComponentState createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  TextEditingController? _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: 150.0,
        decoration: BoxDecoration(
          color: AppTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              child: Container(
                width: 50.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).lineColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  AutoSizeText(
                    'Введите название города',
                    maxLines: 1,
                    style: AppTheme.of(context).title2.override(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                          child: OutlinedTextfield(
                            textController: _textController,
                            hintText: 'Название города',
                          ),
                        ),
                      ),
                      AppIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 8.0,
                        borderWidth: 0.0,
                        buttonSize: 50.0,
                        fillColor: AppTheme.of(context).secondaryBackground,
                        icon: Icon(
                          Icons.send_rounded,
                          color: AppTheme.of(context).primaryColor,
                          size: 25.0,
                        ),
                        onPressed: () async {
                          sharedPreference.setSearchText(_textController?.text ?? "Астана");
                          widget.onSubmit(_textController?.text);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OutlinedTextfield extends StatelessWidget {
  final String hintText;
  const OutlinedTextfield({
    Key? key,
    required TextEditingController? textController,
    required this.hintText,
  })  : _textController = textController,
        super(key: key);

  final TextEditingController? _textController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textController,
      autofocus: true,
      obscureText: false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTheme.of(context).bodyText1.override(
              color: AppTheme.of(context).secondaryText,
              fontWeight: FontWeight.normal,
            ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x00000000),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.of(context).primaryColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.of(context).dangerColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.of(context).dangerColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: AppTheme.of(context).secondaryBackground,
        contentPadding: EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 20.0),
      ),
      style: AppTheme.of(context).bodyText1.override(
            fontWeight: FontWeight.normal,
          ),
    );
  }
}
