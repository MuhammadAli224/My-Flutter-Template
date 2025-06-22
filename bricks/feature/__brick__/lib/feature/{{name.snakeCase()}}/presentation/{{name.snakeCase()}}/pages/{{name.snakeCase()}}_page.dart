import '../../../../../global_imports.dart';


class {{name.pascalCase()}}Page extends StatelessWidget {
const {{name.pascalCase()}}Page({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('{{name.pascalCase()}}')),
body: BlocBuilder<{{name.pascalCase()}}Cubit, {{name.pascalCase()}}State>(
builder: (context, state) {
return state.when(
initial: () => const Center(child: Text('Init')),
loading: () => const Center(child: CircularProgressIndicator()),
loaded: (items) => Container(),
error: (msg) => Center(child: Text(msg)),
);
},
),
);
}
}