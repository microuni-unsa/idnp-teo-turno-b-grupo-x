package com.example.cineapp

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.selection.toggleable
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Checkbox
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateMapOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.cineapp.theme.CineAppTheme

private const val MIN_TICKETS = 1
private const val MAX_TICKETS = 5
private const val TICKET_PRICE = 15.00
private const val DISCOUNT_RATE = 0.15

class MainActivity : ComponentActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    enableEdgeToEdge()
    setContent {
      CineAppTheme {
        CineApp()
      }
    }
  }
}

// Modelo de datos para las opciones de extras
data class ExtraOption(
    val id: String,
    val name: String,
    val price: Double,
)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CineApp() {
  // --- Estado de la interfaz ---
  var ticketCount by remember { mutableIntStateOf(value = MIN_TICKETS) }
  val ticketPrice = TICKET_PRICE // Precio por entrada

  // Opciones de Canchita (Popcorn)
  val canchitaOptions = remember {
    listOf(
        ExtraOption(id = "can_p", name = "Canchita Pequeña", price = 8.00),
        ExtraOption(id = "can_m", name = "Canchita Mediana", price = 12.00),
        ExtraOption(id = "can_g", name = "Canchita Grande", price = 16.00),
    )
  }
  val selectedCanchitas = remember { mutableStateMapOf<String, Boolean>() }

  // Opciones de Bebidas / Gaseosas
  val bebidaOptions = remember {
    listOf(
        ExtraOption(id = "beb_p", name = "Gaseosa Pequeña", price = 6.00),
        ExtraOption(id = "beb_m", name = "Gaseosa Mediana", price = 9.00),
        ExtraOption(id = "beb_g", name = "Gaseosa Grande", price = 12.00),
    )
  }
  val selectedBebidas = remember { mutableStateMapOf<String, Boolean>() }

  // Estado del Cupón de Descuento (Checkbox)
  var applyCoupon by remember { mutableStateOf(value = false) }
  val discountPercentage = if (applyCoupon) DISCOUNT_RATE else 0.0 // 15% de descuento al marcar el checkbox

  // --- Cálculos en memoria ---
  val ticketsSubtotal = ticketCount * ticketPrice

  val canchitasTotal = canchitaOptions.sumOf { option ->
    if (selectedCanchitas[option.id] == true) option.price else 0.0
  }

  val bebidasTotal = bebidaOptions.sumOf { option ->
    if (selectedBebidas[option.id] == true) option.price else 0.0
  }

  val subtotal = ticketsSubtotal + canchitasTotal + bebidasTotal
  val discountAmount = subtotal * discountPercentage
  val total = subtotal - discountAmount

  // Estado para mostrar el cuadro de diálogo de compra
  var showDialog by remember { mutableStateOf(value = false) }

  Scaffold(
      topBar = {
        TopAppBar(
            title = { Text("Venta de Entradas - Cine", fontWeight = FontWeight.Bold) },
            colors =
                TopAppBarDefaults.topAppBarColors(
                    containerColor = MaterialTheme.colorScheme.primaryContainer,
                    titleContentColor = MaterialTheme.colorScheme.onPrimaryContainer,
                ),
        )
      }
  ) { innerPadding ->
    Column(
        modifier =
            Modifier.fillMaxSize()
                .padding(paddingValues = innerPadding)
                .verticalScroll(state = rememberScrollState())
                .padding(all = 16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp),
    ) {
      // --- 1. Cantidad de Entradas ---
      Card {
        Column(
            modifier = Modifier.padding(all = 16.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp),
        ) {
          Text("1. Entradas", fontWeight = FontWeight.Bold)
          Row(
              modifier = Modifier.fillMaxWidth(),
              horizontalArrangement = Arrangement.SpaceBetween,
              verticalAlignment = Alignment.CenterVertically,
          ) {
            Column {
              Text("Entrada General")
              Text(
                  "S/ %.2f c/u".format(ticketPrice),
                  fontSize = 12.sp,
                  color = MaterialTheme.colorScheme.onSurfaceVariant,
              )
            }
            Row(verticalAlignment = Alignment.CenterVertically) {
              OutlinedButton(
                  onClick = { ticketCount-- },
                  enabled = ticketCount > MIN_TICKETS,
              ) {
                Text("-")
              }
              Text(
                  "$ticketCount",
                  modifier = Modifier.width(32.dp),
                  textAlign = TextAlign.Center,
                  fontWeight = FontWeight.Bold,
              )
              OutlinedButton(
                  onClick = { ticketCount++ },
                  enabled = ticketCount < MAX_TICKETS,
              ) {
                Text("+")
              }
            }
          }
        }
      }

      // --- 2. Sección de Extras ---
      Card {
        Column(
            modifier = Modifier.padding(all = 16.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp),
        ) {
          Text("2. Extras", fontWeight = FontWeight.Bold)

          Text("Canchita (Popcorn):", fontWeight = FontWeight.SemiBold)
          canchitaOptions.forEach { option ->
            val checked = selectedCanchitas[option.id] == true
            Row(
                modifier =
                    Modifier.fillMaxWidth()
                        .toggleable(
                            value = checked,
                            onValueChange = { selectedCanchitas[option.id] = it },
                            role = Role.Checkbox,
                        )
                        .padding(vertical = 4.dp),
                verticalAlignment = Alignment.CenterVertically,
            ) {
              Checkbox(checked = checked, onCheckedChange = null)
              Text(option.name, modifier = Modifier.weight(1f).padding(start = 8.dp))
              Text("S/ %.2f".format(option.price))
            }
          }

          Text("Bebidas y Gaseosas:", fontWeight = FontWeight.SemiBold)
          bebidaOptions.forEach { option ->
            val checked = selectedBebidas[option.id] == true
            Row(
                modifier =
                    Modifier.fillMaxWidth()
                        .toggleable(
                            value = checked,
                            onValueChange = { selectedBebidas[option.id] = it },
                            role = Role.Checkbox,
                        )
                        .padding(vertical = 4.dp),
                verticalAlignment = Alignment.CenterVertically,
            ) {
              Checkbox(checked = checked, onCheckedChange = null)
              Text(option.name, modifier = Modifier.weight(1f).padding(start = 8.dp))
              Text("S/ %.2f".format(option.price))
            }
          }

          Text("Cupón de Descuento:", fontWeight = FontWeight.SemiBold)
          Row(
              modifier =
                  Modifier.fillMaxWidth()
                      .toggleable(
                          value = applyCoupon,
                          onValueChange = { applyCoupon = it },
                          role = Role.Checkbox,
                      )
                      .padding(vertical = 4.dp),
              verticalAlignment = Alignment.CenterVertically,
          ) {
            Checkbox(checked = applyCoupon, onCheckedChange = null)
            Text(
                "Aplicar cupón promocional (15% de descuento)",
                modifier = Modifier.padding(start = 8.dp),
            )
          }
        }
      }

      // --- 3. Resumen de la Compra ---
      Card(
          colors =
              CardDefaults.cardColors(
                  containerColor = MaterialTheme.colorScheme.primaryContainer,
              )
      ) {
        Column(
            modifier = Modifier.padding(all = 16.dp),
            verticalArrangement = Arrangement.spacedBy(4.dp),
        ) {
          Text("Resumen de la Compra", fontWeight = FontWeight.Bold)
          Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
            Text("Subtotal:")
            Text("S/ %.2f".format(subtotal))
          }
          Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
            Text("Descuento (15%):")
            Text("- S/ %.2f".format(discountAmount))
          }
          Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
            Text("Total a pagar:", fontWeight = FontWeight.Bold, fontSize = 18.sp)
            Text("S/ %.2f".format(total), fontWeight = FontWeight.Bold, fontSize = 18.sp)
          }
        }
      }

      // --- 4. Botón de Comprar ---
      Button(onClick = { showDialog = true }, modifier = Modifier.fillMaxWidth()) {
        Text("Comprar Entradas")
      }
    }
  }

  if (showDialog) {
    AlertDialog(
        onDismissRequest = { showDialog = false },
        title = { Text("Compra confirmada") },
        text = { Text("Total pagado: S/ %.2f".format(total)) },
        confirmButton = { TextButton(onClick = { showDialog = false }) { Text("Aceptar") } },
    )
  }
}
