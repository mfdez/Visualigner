	function colorear(cell, measure, relation) {
		valor = document.getElementById(measure).value;
		relacion = document.getElementById(relation).value;
		if (valor != 0 && relacion != "") {
			celda = document.getElementById(cell).style.backgroundColor="#8B0000";
		}
		else {
			celda = document.getElementById(cell).style.backgroundColor = "#777";
		}
    }
