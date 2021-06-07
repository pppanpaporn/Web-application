import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Editimage_profile extends StatefulWidget {
  @override
  _Editimage_profileState createState() => _Editimage_profileState();
}

class _Editimage_profileState extends State<Editimage_profile> {

  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0,bottom: 12.0),
          child: CircleAvatar(
              radius: 60,
              backgroundImage:
              AssetImage("images/profile.jpg")

          ),
        ),
        Positioned(
            bottom: 1,right: 1,
            child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context, builder: ((builder) => bottomsheet()),
                  );
                },
                child: buildEditIcon(Colors.blue))
        ),
      ],
    );
  }
  Widget buildEditIcon(Color color) => buildCircle(
      child: buildCircle(
          child: Icon(Icons.edit,color: Colors.white,size: 30,)
          , all: 5, color: color), all: 3, color: Colors.white);

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,}) => ClipOval(
    child: Container(
      padding: EdgeInsets.all(all),
      color: color,
      child: child,
    ),
  );

  Widget bottomsheet(){
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20
      ),
      child: Column(
        children: [
          Text('Choose Profile photo'),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton.icon(onPressed: () async {
                  takePhoto(ImageSource.camera);
                }, icon: Icon(Icons.camera), label: Text('Camera'),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton.icon(onPressed: (){
                  takePhoto(ImageSource.gallery);
                }, icon: Icon(Icons.image), label: Text('Image'),),
              )
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source,);
    setState(() {
      _imageFile = pickedFile;
      // _imageFile == null
      //   ? vv = AssetImage("images/profile.jpg")
      //   : vv = FileImage(File(_imageFile!.path));

    });
  }
}
