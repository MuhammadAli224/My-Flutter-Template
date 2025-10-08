import '../../../../../global_imports.dart';


class {{name.pascalCase()}}Page extends StatelessWidget {
const {{name.pascalCase()}}Page({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('{{name.pascalCase()}}')),
body: BlocProvider(
create: (context) => getIt<{{name.pascalCase()}}Cubit>(),
child:Container()),

);
}
}