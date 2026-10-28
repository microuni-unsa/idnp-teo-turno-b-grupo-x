// Fragmento real extraído de AlertaUNI — pantalla única del equipo.
// Fuente: Project-Group-B2/AlertaUNI/app/src/main/java/com/erns/alertauni/screen/post/PostCommentScreen.kt
// Composables: CommentScreenLayout (líneas 66-146) + MessageBubble (líneas 149-184).
// Recorte fiel: se rotuló el contexto de navegación/estado; los layouts y Modifier
// (Column/Row/Box/LazyColumn, fillMaxSize/fillMaxWidth, weight, padding, align) son
// copia exacta del código que corre en el Xiaomi de la captura_base.png.

@Composable
fun CommentScreenLayout(
    username: String,
    title: String,
    comments: List<CommentEntity>,
    onClickAddComment: (String) -> Unit
) {
    val inputText = remember { mutableStateOf("") }

    Column(
        modifier = Modifier
            .fillMaxSize()
    ) {
        SearchBoxComponent(username, title)
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(horizontal = 8.dp)
                .weight(1f),
            reverseLayout = true // To show latest at bottom
        ) {
            items(comments.reversed()) { message ->
                MessageBubble(message)
            }

        }

        // Input area
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 8.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {

            TextField(
                value = inputText.value,
                onValueChange = { inputText.value = it },
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(8.dp),
                // 1. Esquinas redondeadas estilo WhatsApp
                shape = RoundedCornerShape(28.dp),
                // 2. Eliminamos los indicadores visuales de "caja" de Material
                colors = TextFieldDefaults.colors(
                    focusedContainerColor = MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.5f),
                    unfocusedContainerColor = MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.5f),
                    disabledContainerColor = Color.Transparent,
                    focusedIndicatorColor = Color.Transparent,   // Quita la línea al enfocar
                    unfocusedIndicatorColor = Color.Transparent, // Quita la línea al desenfocar
                    disabledIndicatorColor = Color.Transparent
                ),
                placeholder = {
                    Text("Mensaje", color = Color.Gray)
                },
                trailingIcon = {
                    IconButton(onClick = {
                        if (inputText.value.isNotBlank()) {
                            onClickAddComment(inputText.value)
                            inputText.value = ""
                        }
                    }) {
                        Icon(
                            Icons.AutoMirrored.Outlined.Send,
                            contentDescription = "Enviar",
                            tint = Color.Gray,
                            modifier = Modifier.rotate(0f)
                        )
                    }
                },
                maxLines = 5 // Permite que crezca un poco antes de hacer scroll interno
            )

        }

    }


}

@Composable
fun MessageBubble(message: CommentEntity) {
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 4.dp),
        contentAlignment = if (message.isMine) Alignment.CenterEnd else Alignment.CenterStart
    ) {
        Surface(
            shape = RoundedCornerShape(16.dp),
            color = if (message.isMine) Color(0xFFDCF8C6) else Color.White,
            shadowElevation = 2.dp
        ) {
            Column(
                modifier = Modifier.padding(12.dp)
            ) {
                if (!message.isMine) {
                    Text(
                        text = message.authorName,
                        color = Color.Red,
                        fontSize = 12.sp
                    )
                }
                Text(
                    text = message.content,
                    textAlign = if (message.isMine) TextAlign.End else TextAlign.Start
                )
                Text(
                    text = message.publishedDate,
                    style = MaterialTheme.typography.bodySmall,
                    color = Color.Gray,
                    modifier = Modifier.align(if (message.isMine) Alignment.End else Alignment.Start)
                )
            }
        }
    }
}
