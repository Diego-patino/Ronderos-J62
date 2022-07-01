# RONDEROS

Aqui en Ronderos nos encargamos de ofrecer un app de facil control sobre las familias y los miembros registrados (tanto manuales como automaticos) vinculado con la base de datos de Firebase, mas a futuro ofreceremos:

    - Una alerta de robos; para mantener al tanto a todos los miembros de las vulnerabilidades que puedan ocurrirle a alguno de ellos.
    - Un mapa vinculado con Google Maps para ubicar correspondientemente a los miembros tanto de la familia como del barrio.
    - Un chat que facilite la comunicacion entre los miembros.

## PRUEBAS FUNCIONALES DEL APLICATIVO RONDEROS

Register:
Como Usuario tendras que realizar estos sencillos pasos para poder registrarte.
  - Registrate ingresando tu: Nombre, Apellido, Correo, y contraseña.
  - Comprueba si la informacion ingresada es como te la piden
  - Comprueba si las contraseñas ingresadas son las mismas.
  - Presiona el boton y verifica si te permitio ingresar a la pagina de Inicio del app.
  - Verifica si en el Drawer (Dando click en el boton de tu foto arriba a la izquierda de la pantalla) esta toda tu informacion correctamente.
  
  (El Boton te registrara con toda la informacion dentro de nuestra base de datos en Firebase).
  
Salir del App:
¿Ya te vas tan rapido? Si es asi presiona el boton "SALIR" del Drawer.
  - Confirma el formulario de salida.
  - Verifica si te encuentras en el Login.
  
  (El app registrara tu salida del app con tu cuenta en Auth. y hasta que no te vuelvas a logear te pedira que ingreses con una cuenta).
  
Login:
Si quieres logearte deberas seguir estos pasos:
  - Ingresa tu correo y contraseña correctamente
  - Ingresa en el boton ingresar para comprobar si existe dentro de la base de datos.
  - Si la informacion ingresada es la correcta te permitira logearte.
  - Comprueba si te reenvio a la pagina de Inicio
  
  (El boton comprobara si existe un usuario con ese correo y contraseña dentro del Auth.)
  
Mantenerte logeado:
Si cierras y vuelves a abrir el aplicativo, se guardara tu informacion para que ya no tengas que logearte de nuevo.
  - Cierra o minimiza el app.
  - Vuelvelo a abrir y comprueba si aun te encuentras logeado con tu cuenta.
  
  (El app registra el inicio de tu cuenta de Auth. y te mantendra logeado hasta que decidas desloguearte).
  
  
Registrate a una familia:
Como usuario nuevo deberas registrarte a una familia ya existente o crear una nueva.
  - En la pestaña Familia da click en "Aqui".
  - Ingresa el nombre de la familia (Para poder ver integrantes porfavor ingresa a nuestra familia Ronderos),
  - Ingresa el tipo de familiar que eres.
  - Comprueba si toda la informacion fue agregada tal como te la piden.
  - Ingresa en el boton "Guardar" y comprueba en la pestaña familia si puedes visualizarte a ti y a los miembros de tu nueva familia.
  - Comprueba si en el Drawer (Dando click en el boton de tu foto arriba a la izquierda de la pantalla), si se te visualiza tu familia y el tipo de miembro que eres.
  
  (El boton enviara tu informacion respectiva y te agregara como miembro dentro de la familia en su base de datos).
  
Cambiar de foto:
¿No te gusta tu actual foto? puedes cambiartela ingresando al boton de configuraciones en el Drawer.
  - Ingresa en mi Cuenta.
  - Ingresa en la camara verde en medio de tu foto actual.
  - Elije en tu galeria que foto prefieres tener.
  - Ingresa en el boton "Guardar", confirma el formulario y comprueba si te reenvio al Login.
  - Vuelve a logearte y comprueba si tu foto se cambio tanto en tu perfil del Drawer como en tu perfil de familia.
  
  (El boton enviara tu foto al Storage de Firebase y lo recibira como link para reenviarlo a tus perfiles respectivos).
  
Cambiar de Nombre o Apellido:
¿Te equivocaste de informacion? puedes cambiarla ingresando al boton de configuraciones en el Drawer.
  - Ingresa en mi Cuenta.
  - Presiona el lapiz para editar tu nombre/apellido.
  - Cambia tu nombre o apellido a tu gusto (Si quieres los dos o solo uno).
  - Presiona en el boton "Guardar", confirma en el formulario y comprueba si te reenvio al Login.
  - Vuelve a logearte y comprueba si tu informacion se cambio tanto en tu perfil del Drawer como en tu perfil de familia.
  
  (El boton cambiara tu informacion respectiva en tus perfiles de la base de datos).
  
Cambiar contraseña:
Si deseas cambiar tu contraseña, puedes hacerlo ingresando al boton de configuracion.
  - Ingresa en Contraseña.
  - Ingresa tu contraseña actual y tu nueva contraseña.
  - Repite tu nueva contraseña y comprueba si las dos contraseñas ingresadas concuerdan.
  - Comprueba si la informacion ingresada fue correcta.
  - Presiona el boton "Cambiar Contraseña", confirma el formulario y comprueba si te reenvio al Login.
  - Comprueba si te permite ingresar con tu nueva contraseña.
  
  (El boton cambiara tu contraseña tanto en el Auth. como en tu perfil de usuario)
  
Salirse de Familia:
Si deseas salirte de tu familia actual, puedes hacer en configuraciones.
  - Ingresa a Salirse de Familia.
  - Comprueba si la familia que visualizas es tu familia actual.
  - Comprueba si los miembros que visualizas son los de tu familia actual.
  - Presiona el boton "Salir de Familia", confirma el formulario y comprueba si te reenvio a la Pagina de Login.
  - Comprueba en el Drawer y en la pestaña de Familia si cuentas con una familia actual.
  
  (El boton te eliminara de la base de datos de la familia y te borrará tu familia de tu perfil principal).
  
Borrar Cuenta:
Finalmente, si deseas borrar tu cuenta de una vez por todas podras hacerlo desde la ventana de configuraciones.
  - Ingresa a Borrar Cuenta.
  - Si estas completamente seguro, presiona en Proceder.
  - Ingresa tu contraseña actual, si la contraseña ingresada coincide con tu contraseña actual te saldra una ventana de confirmacion.
  - Confirma el Formulario
  - Comprueba que te encuentras en el Login y comprueba si aun puedes logearte con tu cuenta.
  
  (El boton eliminara todos tus datos de nuestras bases de datos)
  
## FUNCIONALIDAD EXTRA

Agregar como admin:
Si eres administrador de tu familia, podras agregar miembros nuevos a tu familia; para ello te ofrecemos una cuenta admin de la familia Ronderos para que uses.
  - Logeate con el correo: Pablo@gmail.com, contraseña: Pablo123.
  - Ingresa a la pagina de Familia.
  - Ingresa el nombre, apellido y Arbol(miembro de familia) del nuevo integrante;
  - Si has llenado todos los recuadros correctamente, presiona el boton crear.
  - Comprueba si se creó un nuevo usuario y buscalo dentro de los integrantes.
  
  (El boton crea un nuevo usuario dentro de la base de datos, esto es para aquellos integrantes que no cuenten con un celular).
  

 
