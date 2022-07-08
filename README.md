# RONDEROS

Aqui en Ronderos nos encargamos de ofrecer un app de facil control sobre las familias y los miembros registrados (tanto manuales como automaticos) vinculado con la base de datos de Firebase, mas a futuro ofreceremos:

    - Una alerta de robos; para mantener al tanto a todos los miembros de las vulnerabilidades que puedan ocurrirle a alguno de ellos.
    -̵U̵n̵ ̵m̵a̵p̵a̵ ̵v̵i̵n̵c̵u̵l̵a̵d̵o̵ ̵c̵o̵n̵ ̵G̵o̵o̵g̵l̵e̵ ̵M̵a̵p̵s̵ ̵p̵a̵r̵a̵ ̵u̵b̵i̵c̵a̵r̵  ̵c̵o̵r̵r̵e̵s̵p̵o̵n̵d̵i̵e̵n̵t̵e̵m̵e̵n̵t̵e̵ ̵a̵ ̵l̵o̵s̵ ̵m̵i̵e̵m̵b̵r̵o̵s̵ ̵t̵a̵n̵t̵o̵ ̵d̵e̵ ̵l̵a̵ ̵f̵a̵m̵i̵l̵i̵a̵ ̵c̵o̵m̵o̵ ̵d̵e̵l̵ ̵b̵a̵r̵r̵i̵o̵.
    - Un chat que facilite la comunicacion entre los miembros.

## PRUEBAS FUNCIONALES DEL APLICATIVO RONDEROS

**Register:**
Como Usuario tendras que realizar estos sencillos pasos para poder registrarte.
  - Registrate ingresando tu: Nombre, Apellido, Correo, y contraseña.
  - Comprueba si la informacion ingresada es como te la piden
  - Comprueba si las contraseñas ingresadas son las mismas.
  - Presiona el boton y verifica si te permitio ingresar a la pagina de Inicio del app.
  - Verifica si en el Drawer (Dando click en el boton de tu foto arriba a la izquierda de la pantalla) esta toda tu informacion correctamente.
  
  (El Boton te registrara con toda la informacion dentro de nuestra base de datos en Firebase).
  
**Salir del App:**
¿Ya te vas tan rapido? Si es asi presiona el boton "SALIR" del Drawer.
  - Confirma el formulario de salida.
  - Verifica si te encuentras en el Login.
  
  (El app registrara tu salida del app con tu cuenta en Auth. y hasta que no te vuelvas a logear te pedira que ingreses con una cuenta).
  
**Login:**
Si quieres logearte deberas seguir estos pasos:
  - Ingresa tu correo y contraseña correctamente
  - Ingresa en el boton ingresar para comprobar si existe dentro de la base de datos.
  - Si la informacion ingresada es la correcta te permitira logearte.
  - Comprueba si te reenvio a la pagina de Inicio
  
  (El boton comprobara si existe un usuario con ese correo y contraseña dentro del Auth.)
  
**Mantenerte logeado:**
Si cierras y vuelves a abrir el aplicativo, se guardara tu informacion para que ya no tengas que logearte de nuevo.
  - Cierra o minimiza el app.
  - Vuelvelo a abrir y comprueba si aun te encuentras logeado con tu cuenta.
  
  (El app registra el inicio de tu cuenta de Auth. y te mantendra logeado hasta que decidas desloguearte).
  
  
**Registrate a una familia:**
Como usuario nuevo deberas registrarte a una familia ya existente o crear una nueva.
  - En la pestaña Familia da click en "Aqui".
  - Ingresa el nombre de la familia (Para poder ver integrantes porfavor ingresa a nuestra familia Ronderos),
  - Ingresa el tipo de familiar que eres.
  - Comprueba si toda la informacion fue agregada tal como te la piden.
  - Ingresa en el boton "Guardar" y comprueba en la pestaña familia si puedes visualizarte a ti y a los miembros de tu nueva familia.
  - Comprueba si en el Drawer (Dando click en el boton de tu foto arriba a la izquierda de la pantalla), si se te visualiza tu familia y el tipo de miembro que eres.
  
  (El boton enviara tu informacion respectiva y te agregara como miembro dentro de la familia en su base de datos).
  
**Cambiar de foto:**
¿No te gusta tu actual foto? puedes cambiartela ingresando al boton de configuraciones en el Drawer.
  - Ingresa en mi Cuenta.
  - Ingresa en la camara verde en medio de tu foto actual.
  - Elije en tu galeria que foto prefieres tener.
  - Ingresa en el boton "Guardar", confirma el formulario y comprueba si te reenvio al Login.
  - Vuelve a logearte y comprueba si tu foto se cambio tanto en tu perfil del Drawer como en tu perfil de familia.
  
  (El boton enviara tu foto al Storage de Firebase y lo recibira como link para reenviarlo a tus perfiles respectivos).
  
**Cambiar de Nombre o Apellido:**
¿Te equivocaste de informacion? puedes cambiarla ingresando al boton de configuraciones en el Drawer.
  - Ingresa en mi Cuenta.
  - Presiona el lapiz para editar tu nombre/apellido.
  - Cambia tu nombre o apellido a tu gusto (Si quieres los dos o solo uno).
  - Presiona en el boton "Guardar", confirma en el formulario y comprueba si te reenvio al Login.
  - Vuelve a logearte y comprueba si tu informacion se cambio tanto en tu perfil del Drawer como en tu perfil de familia.
  
  (El boton cambiara tu informacion respectiva en tus perfiles de la base de datos).
  
**Cambiar contraseña:**
Si deseas cambiar tu contraseña, puedes hacerlo ingresando al boton de configuracion.
  - Ingresa en Contraseña.
  - Ingresa tu contraseña actual y tu nueva contraseña.
  - Repite tu nueva contraseña y comprueba si las dos contraseñas ingresadas concuerdan.
  - Comprueba si la informacion ingresada fue correcta.
  - Presiona el boton "Cambiar Contraseña", confirma el formulario y comprueba si te reenvio al Login.
  - Comprueba si te permite ingresar con tu nueva contraseña.
  
  (El boton cambiara tu contraseña tanto en el Auth. como en tu perfil de usuario)
  
**Salirse de Familia:**
Si deseas salirte de tu familia actual, puedes hacer en configuraciones.
  - Ingresa a Salirse de Familia.
  - Comprueba si la familia que visualizas es tu familia actual.
  - Comprueba si los miembros que visualizas son los de tu familia actual.
  - Presiona el boton "Salir de Familia", confirma el formulario y comprueba si te reenvio a la Pagina de Login.
  - Comprueba en el Drawer y en la pestaña de Familia si cuentas con una familia actual.
  
  (El boton te eliminara de la base de datos de la familia y te borrará tu familia de tu perfil principal).
  
**Borrar Cuenta:**
Finalmente, si deseas borrar tu cuenta de una vez por todas podras hacerlo desde la ventana de configuraciones.
  - Ingresa a Borrar Cuenta.
  - Si estas completamente seguro, presiona en Proceder.
  - Ingresa tu contraseña actual, si la contraseña ingresada coincide con tu contraseña actual te saldra una ventana de confirmacion.
  - Confirma el Formulario
  - Comprueba que te encuentras en el Login y comprueba si aun puedes logearte con tu cuenta.
  
  (El boton eliminara todos tus datos de nuestras bases de datos)
  
## FUNCIONALIDAD EXTRA

 ̶*̶*̶A̶g̶r̶e̶g̶a̶r̶ ̶c̶o̶m̶o̶ ̶a̶d̶m̶i̶n̶:̶*̶*̶
̶S̶i̶ ̶e̶r̶e̶s̶ ̶e̶l̶ ̶l̶i̶d̶e̶r̶ ̶d̶e̶ ̶t̶u̶ ̶f̶a̶m̶i̶l̶i̶a̶,̶ ̶p̶o̶d̶r̶a̶s̶ ̶a̶g̶r̶e̶g̶a̶r̶ ̶m̶i̶e̶m̶b̶r̶o̶s̶ ̶n̶u̶e̶v̶o̶s̶;̶ ̶p̶a̶r̶a̶ ̶e̶l̶l̶o̶ ̶t̶e̶ ̶o̶f̶r̶e̶c̶e̶m̶o̶s̶ ̶u̶n̶a̶ ̶c̶u̶e̶n̶t̶a̶ ̶d̶e̶ ̶l̶i̶d̶e̶r̶ ̶d̶e̶ ̶l̶a̶ ̶f̶a̶m̶i̶l̶i̶a̶ ̶R̶o̶n̶d̶e̶r̶o̶s̶ ̶p̶a̶r̶a̶ ̶q̶u̶e̶ ̶l̶a̶ ̶u̶s̶e̶s̶.̶
̶ ̶ ̶-̶ ̶L̶o̶g̶e̶a̶t̶e̶ ̶c̶o̶n̶ ̶e̶l̶ ̶c̶o̶r̶r̶e̶o̶:̶ ̶P̶a̶b̶l̶o̶@̶g̶m̶a̶i̶l̶.̶c̶o̶m̶,̶ ̶c̶o̶n̶t̶r̶a̶s̶e̶ñ̶a̶:̶ ̶P̶a̶b̶l̶o̶1̶2̶3̶.̶
̶ ̶ ̶-̶ ̶I̶n̶g̶r̶e̶s̶a̶ ̶a̶ ̶l̶a̶ ̶p̶a̶g̶i̶n̶a̶ ̶d̶e̶ ̶F̶a̶m̶i̶l̶i̶a̶.̶
̶ ̶ ̶-̶ ̶I̶n̶g̶r̶e̶s̶a̶ ̶e̶l̶ ̶n̶o̶m̶b̶r̶e̶,̶ ̶a̶p̶e̶l̶l̶i̶d̶o̶ ̶y̶ ̶A̶r̶b̶o̶l̶(̶m̶i̶e̶m̶b̶r̶o̶ ̶d̶e̶ ̶f̶a̶m̶i̶l̶i̶a̶)̶ ̶d̶e̶l̶ ̶n̶u̶e̶v̶o̶ ̶i̶n̶t̶e̶g̶r̶a̶n̶t̶e̶;̶
̶ ̶ ̶-̶ ̶S̶i̶ ̶h̶a̶s̶ ̶l̶l̶e̶n̶a̶d̶o̶ ̶t̶o̶d̶o̶s̶ ̶l̶o̶s̶ ̶r̶e̶c̶u̶a̶d̶r̶o̶s̶ ̶c̶o̶r̶r̶e̶c̶t̶a̶m̶e̶n̶t̶e̶,̶ ̶p̶r̶e̶s̶i̶o̶n̶a̶ ̶e̶l̶ ̶b̶o̶t̶o̶n̶ ̶c̶r̶e̶a̶r̶.̶
̶ ̶ ̶-̶ ̶C̶o̶m̶p̶r̶u̶e̶b̶a̶ ̶s̶i̶ ̶s̶e̶ ̶c̶r̶e̶ó̶ ̶u̶n̶ ̶n̶u̶e̶v̶o̶ ̶u̶s̶u̶a̶r̶i̶o̶ ̶y̶ ̶b̶u̶s̶c̶a̶l̶o̶ ̶d̶e̶n̶t̶r̶o̶ ̶d̶e̶ ̶l̶o̶s̶ ̶i̶n̶t̶e̶g̶r̶a̶n̶t̶e̶s̶.̶
̶ ̶ ̶
̶ ̶ ̶(̶E̶l̶ ̶b̶o̶t̶o̶n̶ ̶c̶r̶e̶a̶ ̶u̶n̶ ̶n̶u̶e̶v̶o̶ ̶u̶s̶u̶a̶r̶i̶o̶ ̶d̶e̶n̶t̶r̶o̶ ̶d̶e̶ ̶l̶a̶ ̶b̶a̶s̶e̶ ̶d̶e̶ ̶d̶a̶t̶o̶s̶,̶ ̶e̶s̶t̶o̶ ̶e̶s̶ ̶p̶a̶r̶a̶ ̶a̶q̶u̶e̶l̶l̶o̶s̶ ̶i̶n̶t̶e̶g̶r̶a̶n̶t̶e̶s̶ ̶q̶u̶e̶ ̶n̶o̶ ̶c̶u̶e̶n̶t̶e̶n̶ ̶c̶o̶n̶ ̶u̶n̶ ̶c̶e̶l̶u̶l̶a̶r̶)̶.̶
  

 
