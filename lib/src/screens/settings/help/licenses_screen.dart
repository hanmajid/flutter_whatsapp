import 'package:flutter/material.dart';

class LicensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: ListView(
          children: <Widget>[
            Text(license,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[600],
            ),)
          ],
        ),
      ),
    );
  }

}

String license = 'This-app-is-just-for-fun license.\n\n\n-----\n\n\n'
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis pretium blandit augue, nec blandit ipsum. Etiam ac velit faucibus, vehicula turpis et, tincidunt nisl. Etiam hendrerit fringilla justo ac consectetur. Donec dolor lectus, egestas nec eros nec, porttitor feugiat justo. In consequat eget lorem in sagittis. Suspendisse mollis, ligula et malesuada luctus, dui est ultrices neque, sollicitudin malesuada diam nisi at lacus. Nam ultrices scelerisque tempus. Curabitur eget efficitur nulla. Quisque ornare est vestibulum, porta nisi nec, posuere arcu. Aliquam at consectetur neque, at vehicula risus. Sed ante ligula, tristique nec ipsum nec, viverra vulputate tortor. Etiam ultricies malesuada sapien, in commodo odio gravida tristique. Fusce ac arcu sit amet libero scelerisque efficitur. Suspendisse feugiat imperdiet tempor. Mauris iaculis purus risus, in scelerisque nunc consequat eu.\n\n'
'Phasellus ut metus sit amet orci maximus semper a nec risus. Donec convallis dolor ut mollis varius. Fusce malesuada diam nec nisi rhoncus posuere. Vivamus posuere velit nec neque ullamcorper, ut cursus dolor vulputate. Aliquam erat volutpat. Aenean at metus mauris. In eget purus lectus. Suspendisse aliquet ac magna a sollicitudin. Morbi fringilla nisi ut elit pretium, ac egestas ligula tempus. Nam dictum purus facilisis nibh pharetra commodo.\n\n'
'Praesent at laoreet lacus. Mauris pharetra elit nec nisl vulputate venenatis. Donec congue malesuada magna at ultricies. Aenean finibus scelerisque consectetur. Fusce sagittis, orci et ultricies consectetur, dolor tortor scelerisque urna, sed dapibus enim nisi elementum arcu. Duis tempor pellentesque dolor sit amet lobortis. Cras accumsan velit neque, et blandit mauris tincidunt eu. Phasellus lacus massa, pretium sit amet nulla non, feugiat cursus ex. Praesent vulputate mi at ultricies fermentum. Sed pellentesque quis metus non sodales.\n\n'
'Vestibulum non tellus ut nisl faucibus posuere sed dignissim nisi. Proin vitae nibh risus. Nam fermentum efficitur nulla, consectetur hendrerit dolor pharetra finibus. Proin quis scelerisque magna. Mauris posuere eu erat et aliquam. Suspendisse euismod sapien vitae ullamcorper mollis. In mollis tempus lacinia. Vivamus quis viverra erat.\n\n'
'Etiam nec lacus sit amet lacus sollicitudin molestie ornare ac ligula. Praesent enim orci, interdum a nisi non, lobortis tristique velit. Vivamus lacinia mattis ligula eu volutpat. Suspendisse facilisis pellentesque massa, id sagittis orci ullamcorper ut. Nunc egestas facilisis neque ut pretium. In nunc nibh, porta at rutrum sed, venenatis eu magna. Praesent non pellentesque sem, non venenatis nibh. Nullam tempor, erat sit amet cursus lacinia, justo erat sagittis lectus, id venenatis odio dolor at justo. Proin in quam est. Curabitur sodales, tellus et efficitur cursus, turpis orci pellentesque nibh, vel feugiat lectus nulla eu urna. Duis ante lacus, rutrum at magna ac, lobortis accumsan metus. Nunc fringilla lectus non lectus mattis volutpat ac vitae mauris.\n\n'
'Suspendisse eu metus aliquet tellus tincidunt hendrerit. In a tempus arcu. Vivamus at massa eget tortor lobortis fermentum vitae quis nisl. Aliquam eget dignissim sapien. In hac habitasse platea dictumst. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Integer eleifend tincidunt nibh vitae fringilla.\n\n'
'Etiam vitae ligula ut tellus dignissim cursus in ut ex. Nunc vitae dui blandit, congue justo id, iaculis nibh. Nunc facilisis ex ligula, ut facilisis ex auctor nec. Ut pellentesque risus sem, ut scelerisque ante malesuada eget. Vestibulum varius mollis risus vel convallis. Fusce sodales purus vitae malesuada elementum. Nunc euismod faucibus enim, vel volutpat dui maximus ac. Nam convallis ante risus, in posuere elit consequat eget. In hac habitasse platea dictumst. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Cras in facilisis nunc. Nulla sagittis diam vitae venenatis vehicula.\n\n'
'Praesent eu ex id diam lobortis laoreet. Praesent neque ligula, aliquam in congue ut, ultricies vitae lectus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aliquam dapibus ut turpis id efficitur. Donec nisl magna, consequat ut tellus sed, accumsan facilisis nisl. Mauris orci augue, tempus ac sem ac, lacinia aliquet arcu. Curabitur id leo iaculis, mollis massa tempor, dapibus sem. Donec pulvinar eleifend orci. Aenean a mi finibus, semper sem sit amet, ultricies eros. Mauris euismod sit amet neque vel commodo.\n\n'
'Pellentesque egestas condimentum iaculis. Praesent molestie sem eget ante elementum vestibulum. Aenean convallis vulputate bibendum. Sed non tincidunt neque. Nunc sed arcu a diam laoreet bibendum. Praesent vitae malesuada nulla, eu porttitor orci. Fusce aliquet accumsan lacus, ornare rutrum mauris pharetra ac. Mauris ligula orci, vehicula ac sollicitudin sagittis, laoreet ac felis. Phasellus ac eros erat. Quisque eget vehicula sapien, eleifend porta nunc. Nunc ornare luctus felis. Sed ut odio hendrerit odio sagittis dignissim. Phasellus vitae dui ut metus volutpat consectetur nec nec turpis.\n\n'
'Vivamus purus turpis, pellentesque a feugiat ut, vehicula id elit. Donec blandit at lacus vitae consequat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In hac habitasse platea dictumst. Praesent sed blandit lorem, et ullamcorper ipsum. Nullam eget semper urna, eu consectetur mi. Nullam dictum euismod massa et egestas. Sed convallis a lectus et bibendum. Proin ac libero sit amet risus vestibulum dapibus id ultrices odio. Ut id pellentesque tellus. Ut posuere in sem vitae pharetra. Vestibulum vitae augue vel odio bibendum congue. Curabitur id commodo tortor. Nulla at pellentesque libero. Sed aliquam nisi sem, vel pulvinar nisi congue id. Nulla mattis tortor ac est cursus dignissim.\n';