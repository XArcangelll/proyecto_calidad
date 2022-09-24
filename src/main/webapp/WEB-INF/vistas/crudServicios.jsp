<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="esS">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<link rel="icon" type="image/png" href="images/logo.png">
<title>Proyecto Integrador</title>

<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrapValidator.js"></script>

<link rel="stylesheet" href="css/bootstrapValidator.css" />
</head>

<body class="">
	<div class="wrapper ">
		<jsp:include page="menuLateral.jsp" />
		<div class="main-panel">
			<jsp:include page="menuSuperior.jsp" />
			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="card-header card-header-primary">
									<h3 class="card-title">
										<i class="material-icons">medical_services</i> Datos de
										Servicio
									</h3>
									<p class="card-category">Mantenimiento</p>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-12">
													<form accept-charset="UTF-8">
														<div class="card-body" style="padding: 20px 10px;">
															<div class="row">
																<div class="col-md-12">
																	<button type="button"
																		onclick="verModalServicioRegistra();"
																		class="btn btn-primary pull-left">Registrar
																		Servicio</button>
																	<button id="id_validarFechas" type="button"
																		onclick="validarFechas();"
																		class="btn btn-primary pull-right">Actualizar
																		Fechas</button>
																</div>
															</div>
															<br />
															<div class="row" style="overflow: auto;">
																<table id="tablaServicios" class="table table-hover">
																	<thead class="text-primary">
																		<tr>
																			<th>ID</th>
																			<th>Nombre</th>
																			<th style="width: 85px;">Precio</th>
																			<th>Descripci�n</th>
																			<th>D�a</th>
																			<th>Horarios</th>
																			<th>Imagen</th>
																			<th style="width: 102.4px;">Editar</th>
																			<th style="width: 102.4px;">Eliminar</th>
																		</tr>
																	</thead>
																	<tbody>
																		<c:forEach items="${servicios}" var="servicio">
																			<tr>
																				<td>${servicio.idServicio}</td>
																				<td>${servicio.nombre}</td>
																				<td>S/. ${servicio.precio}</td>
																				<td>${servicio.descripcion}</td>
																				<td>${servicio.dia}</td>
																				<td><c:forEach items="${horarios}"
																						var="horario">
																						<c:if
																							test="${horario.idServicio.idServicio == servicio.idServicio}">
																							${horario.horario}
																						</c:if>
																					</c:forEach></td>
																				<td><img src="${servicio.imagen}" alt="#"
																					width="50px" height="50px"></td>
																				<td>
																					<button type="button"
																						onclick="verModalServicioModifica('${servicio.idServicio}','${servicio.nombre}','${servicio.precio}','${servicio.descripcion}','${servicio.dia}');"
																						class="btn btn-primary">
																						<img src="images/edit.gif" width="auto"
																							height="auto" />
																					</button>
																				</td>
																				<td>
																					<button type="button"
																						onclick="verModalServicioElimina('${servicio.idServicio}');"
																						class="btn btn-primary">
																						<img src="images/delete.gif" width="auto"
																							height="auto" />
																					</button>
																				</td>
																			</tr>
																		</c:forEach>
																	</tbody>
																</table>
															</div>
														</div>
													</form>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal de Registro de Servicio -->

		<div class="modal fade" id="idModalRegistraServicio"
			data-backdrop="static" tabindex="-1" role="dialog">
			<div class="modal-dialog" style="width: 45%;">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="card">
						<div class="card-header card-header-primary">
							<h3 class="card-title">Registrar Servicio</h3>
						</div>
						<div class="card-body" style="padding: 20px 18px;">
							<form accept-charset="UTF-8" id="id_formRegistrarServicio"
								enctype="multipart/form-data">
								<div class="row" id="id_divNombreRegistrar">
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label-floating">Nombre de Servicio</label>
											<input class="form-control" type="text"
												id="id_nombreRegistrar" name="nombre">
										</div>
									</div>
								</div>
								<div class="row" id="id_divPrecioRegistrar">
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label-floating">Precio</label> <input
												class="form-control" type="text" id="id_precioRegistrar"
												name="precio">
										</div>
									</div>
								</div>
								<div class="row" id="id_divDescripcionRegistrar">
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label-floating">Descripci�n</label> <input
												class="form-control" type="text"
												id="id_descripcionRegistrar" name="descripcion">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label">D�a de Servicio</label><br>
											<div class="row">
												<div style="width: 110px; height: auto; padding-left: 25px;">
													<input type="radio" name="dia" value="Lunes" checked>
													Lunes
												</div>
												<div style="width: 110px; height: auto;">
													<input type="radio" name="dia" value="Martes">
													Martes
												</div>
												<div style="width: 110px; height: auto;">
													<input type="radio" name="dia" value="Mi�rcoles">
													Mi�rcoles
												</div>
												<div style="width: 110px; height: auto;">
													<input type="radio" name="dia" value="Jueves">
													Jueves
												</div>
												<div style="width: 110px; height: auto;">
													<input type="radio" name="dia" value="Viernes">
													Viernes
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-9">
										<div class="form-group">
											<label class="bmd-label-floating">Horas</label> <input
												class="form-control" type="text" id="id_horarioRegistrar"
												name="horario" maxlength="2"
												onkeypress='return validaNumericos(event);'><small
												id="id_mensajeHoraConfirmarRegistrar"
												style="color: #cc0000;">Ingrese el horario</small>
										</div>
									</div>
									<button type="button" onclick="agregarHorarioRegistrar();"
										class="btn btn-primary pull-right" style="height: 44px;">Agregar</button>
								</div>
								<div class="row" id="id_horariosServiciosRegistrar"></div>
								<div class="row" hidden="hidden">
									<div class="col-md-12">
										<div class="form-group">
											<input type="text" class="form-control"
												id="id_ayudaHoraRegistrar" name="horarios">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label">Imagen</label>
										</div>
										<div class="invoiceBox">
											<label for="id_imagenRegistrar" id="boxFileRegistrar"
												class="boxFile" data-text="Seleccionar Imagen">
												Seleccionar Imagen </label> <input id="id_imagenRegistrar"
												name="imagenServicioRegistrar" size="6000" type="file"
												accept="image/x-png,image/jpeg,image/jpg,image/tiff">
										</div>
										<small id="id_mensajeImagenRegistrar" style="color: #cc0000;">Seleccionar
											Imagen</small>
									</div>
								</div>
								<button type="button" onclick="cerrarModalServicioRegistra();"
									class="btn btn-primary pull-right">Cancelar</button>
								<button id="id_btnRegistrarServicio" type="button"
									onclick="registrarServicio();"
									class="btn btn-primary pull-right">Registrar</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal de Modificar Servicio -->
		<div class="modal fade" id="idModalModificaServicio"
			data-backdrop="static" tabindex="-1" role="dialog">
			<div class="modal-dialog" style="width: 45%;">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="card">
						<div class="card-header card-header-primary">
							<h3 class="card-title">Modificar Servicio</h3>
						</div>
						<div class="card-body" style="padding: 20px 18px;">
							<form id="id_formModificarServicio" accept-charset="UTF-8"
								enctype="multipart/form-data">
								<div class="row" hidden="hidden">
									<div class="col-md-12">
										<div class="form-group">
											<input class="form-control" type="text"
												id="id_codigoModificar" name="idServicio">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label-floating">Nombre de Servicio</label>
											<input class="form-control" type="text"
												id="id_nombreModificar" name="nombre">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label-floating">Precio</label> <input
												class="form-control" type="text" id="id_precioModificar"
												name="precio">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label-floating">Descripci�n</label> <input
												class="form-control" type="text"
												id="id_descripcionModificar" name="descripcion">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label">D�a de Servicio</label><br>
											<div class="row" id="id_diasServiciosModificar">
												<div style="width: 110px; height: auto; padding-left: 25px;">
													<input type="radio" name="dia" value="Lunes"> Lunes
												</div>
												<div style="width: 110px; height: auto;">
													<input type="radio" name="dia" value="Martes">
													Martes
												</div>
												<div style="width: 110px; height: auto;">
													<input type="radio" name="dia" value="Mi�rcoles">
													Mi�rcoles
												</div>
												<div style="width: 110px; height: auto;">
													<input type="radio" name="dia" value="Jueves">
													Jueves
												</div>
												<div style="width: 110px; height: auto;">
													<input type="radio" name="dia" value="Viernes">
													Viernes
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-9">
										<div class="form-group">
											<label class="bmd-label-floating">Horas</label> <input
												class="form-control" type="text" id="id_horarioModificar"
												name="horario" maxlength="2"
												onkeypress='return validaNumericos(event);'><small
												id="id_mensajeHoraConfirmarModificar"
												style="color: #cc0000;">Ingrese el horario</small>
										</div>
									</div>
									<button type="button" onclick="agregarHorarioModificar();"
										class="btn btn-primary pull-right" style="height: 44px;">Agregar</button>
								</div>
								<div class="row" id="id_horariosServiciosModificar"></div>
								<div class="row" hidden="hidden">
									<div class="col-md-12">
										<div class="form-group">
											<input type="text" class="form-control"
												id="id_ayudaHoraModificar" name="horarios">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label">Imagen</label>
										</div>
										<div class="invoiceBox">
											<label for="id_imagenModificar" id="boxFileModificar"
												class="boxFile" data-text="Seleccionar Imagen">
												Seleccionar Imagen </label> <input id="id_imagenModificar"
												name="imagenServicioModificar" size="6000" type="file"
												accept="image/x-png,image/jpeg,image/jpg,image/tiff">
										</div>
									</div>
								</div>
								<button type="button" onclick="cerrarModalServicioModifica();"
									class="btn btn-primary pull-right">Cancelar</button>
								<button id="id_btnModificarServicio" type="button"
									onclick="modificarServicio();"
									class="btn btn-primary pull-right">Actualizar</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal de Eliminar Servicio -->
		<div class="modal fade" id="idModalEliminaServicio"
			data-backdrop="static" tabindex="-1" role="dialog">
			<div class="modal-dialog" style="width: 25%;">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="card">
						<div class="card-header card-header-primary">
							<h3 class="card-title">Eliminar Servicio</h3>
						</div>
						<div class="card-body" style="padding: 20px 18px;">
							<form id="id_formEliminarServicio" accept-charset="UTF-8"
								action="eliminarServicio" method="post">
								<div class="row" hidden="hidden">
									<div class="col-md-12">
										<div class="form-group">
											<input class="form-control" type="text"
												id="id_codigoEliminar" name="idServicio">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<span class="pull-center">�Desea eliminar el servicio
												seleccionado?</span>
										</div>
									</div>
								</div>
								<button type="button" onclick="cerrarModalServicioElimina();"
									class="btn btn-primary pull-right">NO</button>
								<button type="button" onclick="eliminarServicio();"
									class="btn btn-primary pull-left">SI</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Script para Horarios e Imagenes -->
	<script type="text/javascript">
		$('#id_mensajeHoraConfirmarRegistrar').hide();
		$('#id_mensajeHoraConfirmarModificar').hide();
		$('#id_mensajeImagenRegistrar').hide();
		imagen('#id_imagenRegistrar', '#boxFileRegistrar',
				'#id_mensajeImagenRegistrar');
		imagen('#id_imagenModificar', '#boxFileModificar', null);
	</script>

	<!-- Script de Modal's  -->
	<script type="text/javascript">
		$("#id_menuCrudServicios").addClass("active");

		function verModalServicioRegistra() {
			$("#idModalRegistraServicio").modal("show");
			$('#boxFileRegistrar').text("Seleccionar Imagen");
			$('#boxFileRegistrar').removeClass("attached");
		}

		function cerrarModalServicioRegistra() {
			contadorReg = 0;
			horasReg = [];
			confirmarReg = 0;
			$("#idModalRegistraServicio").modal("hide");
			$("#idModalRegistraServicio input[type='text']").val("");
			$("#idModalRegistraServicio input[type='file']").val("");
			$("#id_horariosServiciosRegistrar div").remove();
			$("#idModalRegistraServicio div.form-group").removeClass(
					"is-filled has-success");
			$('#id_formRegistrarServicio').data('bootstrapValidator')
					.resetForm();
			$('#id_mensajeHoraConfirmarRegistrar').hide();
			$('#id_mensajeImagenRegistrar').hide();
		}

		function verModalServicioModifica(id, nombre, precio, descripcion, dia) {
			contadorMod = 0;
			horasMod = [];
			confirmarMod = 0;
			$("#id_codigoModificar").val(id);
			$("#id_nombreModificar").val(nombre);
			$("#id_precioModificar").val(precio);
			$("#id_descripcionModificar").val(descripcion);
			$("#id_diasServiciosModificar input[name=dia]").attr("disabled",
					false);
			$("#id_diasServiciosModificar input[name=dia][value='" + dia + "']")
					.prop("checked", true);
			$
					.getJSON(
							'listadoHorariosServicios',
							{
								"idServicio" : id
							},
							function(data) {
								$
										.each(
												data,
												function(index, item) {
													var h = item.horario;
													horasMod.push(h);
													contadorMod = contadorMod + 1;
													if (item.estado == 'ocupado') {
														$(
																"#id_horariosServiciosModificar")
																.append(
																		"<div class='col-md-2' id='id_boton"
													+ item.horario + "'><div class='form-group'>"
																				+ "<h4>"
																				+ item.horario
																				+ ":00</h4></div></div>");
														$(
																"#id_diasServiciosModificar input[name=dia]:not(:checked)")
																.attr(
																		'disabled',
																		true);
													} else {
														$(
																"#id_horariosServiciosModificar")
																.append(
																		"<div class='col-md-2' id='id_boton"
													 + item.horario + "'><div class='form-group'>"
																				+ "<button type='button' class='close' onclick=\"eliminarHorarioModificar('"
																				+ item.horario
																				+ "');\">&times;</button><h4>"
																				+ item.horario
																				+ ":00</h4></div></div>");
													}
												});
								var horariosMod = "";
								for (var i = 0; i < horasMod.length; i++) {
									if ((horasMod.length - 1) == i) {
										horariosMod += horasMod[i];
									} else {
										horariosMod += horasMod[i] + ",";
									}
								}
								$("#id_ayudaHoraModificar").val(horariosMod);
							});
			$("#id_formModificarServicio .col-md-12 .form-group").addClass(
					"is-filled");
			$("#idModalModificaServicio").modal("show");
		}

		function cerrarModalServicioModifica() {
			$('#idModalModificaServicio').modal("hide");
			$("#idModalModificaServicio input[type='text']").val("");
			$("#idModalModificaServicio input[type='file']").val("");
			$("#id_horariosServiciosModificar div").remove();
			$("#idModalModificaServicio div.form-group").removeClass(
					"is-filled has-success");
			$("#id_diasServiciosModificar input[name=dia]").attr("checked",
					false);
			$('#boxFileModificar').text("Seleccionar Imagen");
			$('#boxFileModificar').removeClass("attached");
			$('#id_formModificarServicio').data('bootstrapValidator')
					.resetForm();
			$('#id_mensajeHoraConfirmarModificar').hide();
		}

		function verModalServicioElimina(id) {
			$("#id_codigoEliminar").val(id);
			$
					.ajax({
						type : 'POST',
						data : {
							'idServicio' : id
						},
						url : 'verificarServicio',
						success : function(data) {
							if (data.CONFIRMACION == 'NO') {
								swal(
										"�Aviso!",
										"El Servicio no se puede eliminar porque hay reservas pendientes.",
										"warning");
							} else {
								$("#idModalEliminaServicio").modal("show");
							}
						},
						error : function() {
							swal("�Error!",
									"�Comunicate con el administrador!",
									"error");
						}
					});
		}

		function cerrarModalServicioElimina() {
			$("#idModalEliminaServicio").modal("hide");
		}
	</script>



	<!-- Validaci�n de Registrar  -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#id_formRegistrarServicio')
									.bootstrapValidator(
											{
												message : 'This value is not valid',
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													nombre : {
														selector : "#id_nombreRegistrar",
														validators : {
															notEmpty : {
																message : 'El nombre es obligatorio'
															},
															stringLength : {
																min : 3,
																message : 'El nombre debe ser m�s de 3 caracteres'
															},
															regexp : {
																regexp : /^[a-zA-Z0-9-����������()\s?]+$/,
																message : 'Solo se aceptan letras y numeros'
															}
														}
													},
													precio : {
														selector : "#id_precioRegistrar",
														validators : {
															notEmpty : {
																message : 'El precio es obligatorio'
															},
															regexp : {
																regexp : /^[0-9]*\.?[0-9]{1,2}$/,
																message : 'El precio debe ser real con dos decimales'
															}
														}
													},
													descripcion : {
														selector : "#id_descripcionRegistrar",
														validators : {
															notEmpty : {
																message : 'El descripcion es obligatorio'
															},
															regexp : {
																regexp : /^[a-zA-Z0-9-����������().;,\s?]+$/,
																message : 'Solo se aceptan letras y numeros \n'
															},
															stringLength : {
																min : 5,
																message : 'La descripci�n debe ser m�s de 5 caracteres'
															},

														}
													},
													imagen : {
														selector : "#id_imagenRegistrar",
														validators : {
															notEmpty : {
																message : 'La imagen es obligatoria'
															}
														}
													}
												}
											});
						});
	</script>

	<!-- Validaci�n de Modificar -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#id_formModificarServicio')
									.bootstrapValidator(
											{
												message : 'This value is not valid',
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													nombre : {
														selector : "#id_nombreModificar",
														validators : {
															notEmpty : {
																message : 'El nombre es obligatorio'
															},
															stringLength : {
																min : 3,
																message : 'El nombre debe ser m�s de 3 caracteres'
															},
															regexp : {
																regexp : /^[a-zA-Z0-9-����������()\s?]+$/,
																message : 'Solo se aceptan letras y numeros'
															},
														}
													},
													precio : {
														selector : "#id_precioModificar",
														validators : {
															notEmpty : {
																message : 'El precio es obligatorio'
															},
															regexp : {
																regexp : /^[0-9]*\.?[0-9]{1,2}$/,
																message : 'El precio debe ser real con dos decimales'
															}
														}
													},
													descripcion : {
														selector : "#id_descripcionModificar",
														validators : {
															notEmpty : {
																message : 'El descripcion es obligatorio'
															},
															regexp : {
																regexp : /^[a-zA-Z0-9-����������().;,\s?]+$/,
																message : 'Solo se aceptan letras y numeros'
															},
															stringLength : {
																min : 5,
																message : 'la descripci�n debe ser m�s de 5 caracteres'
															},
														}
													}
												}
											});
						});
	</script>

</body>

</html>




