<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<!-- Modal Mascota Registrar -->

<div class="modal fade" id="idModalRegistraMascota"
	data-backdrop="static" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="width: 40%;">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="card">
				<div class="card-header card-header-primary">
					<h3 class="card-title">Registrar Mascota</h3>
				</div>
				<div class="card-body" style="padding: 20px 18px;">
					<form id="id_formRegistrarMascota" accept-charset="UTF-8"
						enctype="multipart/form-data">
						<div class="row" id="id_divNombreRegistrar">
							<div class="col-md-12">
								<div class="form-group">
									<label class="bmd-label-floating">Nombre</label> <input
										type="text" class="form-control"
										id="id_nombreMascotaRegistrar" name="nombre">
								</div>
							</div>
						</div>
						<div class="row" id="id_divTipoRegistrar">
							<div class="col-md-12">
								<div class="form-group">
									<label class="bmd-label">Tipo</label> <select
										id="id_tipoMascotaRegistrar" class="form-control"
										name="idTipoMascota.idTipoMascota">
										<option value="">[ Seleccionar ]</option>
										<c:forEach var="tipo" items="${tipos}">
											<option value="${tipo.idTipoMascota}">${tipo.nombre}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="row" id="id_divRazaRegistrar">
							<div class="col-md-12">
								<div class="form-group">
									<label class="bmd-label-floating">Raza</label> <input
										type="text" id="id_razaMascotaRegistrar" class="form-control"
										name="raza">
								</div>
							</div>
						</div>
						<div class="row" id="id_divFechaNacRegistrar">
							<div class="col-md-12">
								<div class="form-group">
									<label class="bmd-label">Fecha de Nacimiento</label><br> <input
										type="date" id="id_fechaNacMascotaRegistrar"
										class="form-control" name="fechaNacimiento"
										onkeydown="return false">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<input type="radio" name="sexo" value="Macho" checked>
									Macho <input type="radio" name="sexo" value="Hembra">
									Hembra
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
										name="imagenMascotaRegistrar" size="6000" type="file"
										accept="image/x-png,image/jpeg,image/jpg,image/tiff">
								</div>
								<small id="id_mensajeImagenRegistrar" style="color: #cc0000;">Seleccionar
									Imagen</small>
							</div>
						</div>
						<button type="button" onclick="cerrarModalMascotaRegistra();"
							class="btn btn-primary pull-right">Cancelar</button>
						<button id="id_btnRegistrarMascota" onclick="registrarMascota();"
							type="button" class="btn btn-primary pull-right">Registrar</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
	$('#id_mensajeImagenRegistrar').hide();
	imagen('#id_imagenRegistrar', '#boxFileRegistrar',
			'#id_mensajeImagenRegistrar');

	function verModalMascotaRegistra() {
		$('#boxFileRegistrar').text("Seleccionar Imagen");
		$('#boxFileRegistrar').removeClass("attached");
		$('#idModalRegistraMascota').modal("show");
	}

	function cerrarModalMascotaRegistra() {
		$('#idModalRegistraMascota').modal("hide");
		$("#idModalRegistraMascota input[type='text']").val("");
		$("#idModalRegistraMascota input[type='file']").val("");
		$("#idModalRegistraMascota div.form-group").removeClass(
				"is-filled has-success");
		$('#id_formRegistrarMascota').data('bootstrapValidator').resetForm();
		$('#id_mensajeImagenRegistrar').hide();
	}
</script>


<!-- Validaciones de Registrar -->
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$('#id_formRegistrarMascota')
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
													selector : "#id_nombreMascotaRegistrar",
													validators : {
														notEmpty : {
															message : 'El nombre es obligatorio'
														},
														stringLength : {
															max : 20,
															message : 'El nombre es de 20 caracteres como m�ximo'
														},
														regexp : {
															regexp : /^[a-zA-Z����������\s?]+$/,
															message : 'El nombre solo debe contener letras y no otros caracteres'
														}
													}
												},
												tipo : {
													selector : "#id_tipoMascotaRegistrar",
													validators : {
														notEmpty : {
															message : 'El tipo de mascota es obligatorio y no puede estar vacia'
														},
													}
												},
												raza : {
													selector : "#id_razaMascotaRegistrar",
													validators : {
														notEmpty : {
															message : 'La raza es obligatoria'
														},

														stringLength : {
															max : 40,
															message : 'El nombre es de 40 caracteres como m�ximo'
														},
														regexp : {
															regexp : /^[a-zA-Z����������\s?]+$/,
															message : 'La raza solo debe contener letras y no otros caracteres'
														}
													}
												},
												fecha : {
													selector : "#id_fechaNacMascotaRegistrar",
													validators : {
														notEmpty : {
															message : 'La fecha es obligatoria y no puede estar vacia'
														},
													}
												},
											}
										});
					});
</script>
