import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardTextField extends StatelessWidget {
  const CardTextField({
    this.title,
    this.bold = false,
    this.hint,
    this.textInputType,
    this.inputFormatters,
    this.validator,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.focusNode,
    this.onSubmitted,
  }) : textInputAction =
            onSubmitted == null ? TextInputAction.done : TextInputAction.next;
  final String title;
  final bool bold;
  final String hint;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;
  final int maxLength;
  final TextAlign textAlign;
  final FocusNode focusNode;
  final Function(String) onSubmitted;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: "",
      validator: validator,
      builder: (state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  if (title != null)
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  if (state.hasError)
                    const Text(
                      '     Inválido',
                      style: TextStyle(fontSize: 11, color: Colors.red),
                    )
                ],
              ),
              TextFormField(
                cursorColor: Colors.white,
                style: TextStyle(
                  color: title == null && state.hasError
                      ? Colors.red
                      : Colors.white,
                  fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: const EdgeInsets.symmetric(vertical: 3),
                  hintText: hint,
                  hintStyle: TextStyle(
                      color: title == null && state.hasError
                          ? Colors.red.withAlpha(200)
                          : Colors.white.withAlpha(100)),
                  border: InputBorder.none,
                  isDense: true,
                ),
                keyboardType: textInputType,
                inputFormatters: inputFormatters,
                onChanged: (text) {
                  state.didChange(text);
                },
                maxLength: maxLength,
                textAlign: textAlign,
                focusNode: focusNode,
                onFieldSubmitted: onSubmitted,
                textInputAction: textInputAction,
              ),
            ],
          ),
        );
      },
    );
  }
}
