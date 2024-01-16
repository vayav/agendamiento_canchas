part of values;

class CustomSelectedInput extends StatefulWidget {
  const CustomSelectedInput({
    Key? key,
    required this.listaItems,
    required this.selected,
    required this.text,
    // required this.onSelectedValueChanged,
  }) : super(key: key);

  final List<String> listaItems;
  final Function(String?) selected;
  final String text;
  // final Function(String) onSelectedValueChanged;

  @override
  State<CustomSelectedInput> createState() => _CustomSelectedInputState();
}

class _CustomSelectedInputState extends State<CustomSelectedInput> {
  String? selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        // fillColor: Colors.white,
        //Add isDense true and zero Padding.
        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
      ),
      isExpanded: true,
      hint: Text(
        widget.text,
        style: TextStyle(fontSize: 14),
      ),
      items: widget.listaItems
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return widget.text;
        }
        return null;
      },
      onChanged: widget.selected,
      //(value) {
      //   //Do something when changing the item if you want.
      //   // setState(() {
      //     selected = value.toString();
      //     // widget.onSelectedValueChanged(selected!);
      //   // });
      // },
      onSaved: (value) {},
      buttonStyleData: ButtonStyleData(
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 55,
        padding: const EdgeInsets.only(left: 10, right: 10),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 30,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
