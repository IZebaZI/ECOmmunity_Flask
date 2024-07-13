from flask import Flask, request, render_template, jsonify, url_for, redirect, flash
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'ecommunity'
app.secret_key = 'your_secret_key'

mysql = MySQL(app)

@app.route('/home')
def index():
    return render_template('vistas/homeAdmin.html')


# USUARIOS ------------------------------------------------------------------------------------------------------------
@app.route('/listaUsuarios')
def listaUsuarios():
    try:
        cursor = mysql.connection.cursor()
        cursor.execute('SELECT * FROM usuarios')
        data = cursor.fetchall()
        cursor.close()
        cursor = mysql.connection.cursor()
        cursor.execute('SELECT * FROM usuarios ORDER BY id DESC LIMIT 5')
        recent = cursor.fetchall()
        cursor.close()
        return render_template('listaUsuarios.html', usuarios=data, recientes=recent)
    except Exception as e:
        print(e)
        return 'Error al obtener los usuarios'
    
@app.route('/agregarUsuario', methods=['POST'])
def insertUsuario():
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        nombre = request.form['txtNombreAdd']
        correo = request.form['txtCorreoAdd']
        password = request.form['txtPasswordAdd']
        ubicacion = request.form['txtUbicacionAdd']
        rol = request.form['txtPermisosAdd']
        cursor.execute('INSERT INTO USUARIOS (nombre, correo, password, ubicacion, rol) VALUES (%s, %s, %s, %s, %s)', (nombre, correo, password, ubicacion, rol))
        mysql.connection.commit()

        flash('SuccessUser')
        return redirect(url_for('listaUsuarios'))

@app.route('/editarUsuario/<id>', methods=['POST'])
def updateUsuario(id):
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        nombre = request.form['txtNombreEdit']
        correo = request.form['txtCorreoEdit']
        password = request.form['txtPasswordEdit']
        ubicacion = request.form['txtUbicacionEdit']
        permisos = request.form['txtPermisosEdit']
        cursor.execute('UPDATE USUARIOS SET nombre=%s, correo=%s, password=%s, ubicacion=%s, permisos=%s WHERE id=%s', (nombre, correo, password, ubicacion, permisos, [id]))
        mysql.connection.commit()

        flash('AlertUser')
        return redirect(url_for('listaUsuarios'))

@app.route('/eliminarUsuario/<id>', methods=['POST'])
def deleteUsuario(id):
    cursor = mysql.connection.cursor()
    cursor.execute('DELETE FROM USUARIOS WHERE id=%s', ([id]))
    mysql.connection.commit()

    flash('DeleteUser')
    return redirect(url_for('listaUsuarios'))


# EMPRESAS ------------------------------------------------------------------------------------------------------------
@app.route('/listaEmpresas')
def listaEmpresas():
    try:
        cursor = mysql.connection.cursor()
        cursor.execute('SELECT * FROM empresas')
        data = cursor.fetchall()
        cursor.close()
        
        cursor = mysql.connection.cursor()
        cursor.execute('SELECT * FROM empresas ORDER BY id DESC LIMIT 5')
        recent = cursor.fetchall()
        cursor.close()
        
        return render_template('vistas/listaEmpresas.html', empresas=data, recientes=recent)
    
    except Exception as e:
        print(e)
        return 'Error al obtener las empresas'

@app.route('/agregarEmpresa', methods=['POST'])
def insertEmpresa():
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        nombre = request.form['txtNombreAdd']
        tipo = request.form['txtTipoAdd']
        ubicacion = request.form['txtUbicacionAdd']
        correo = request.form['txtCorreoAdd']
        telefono = request.form['intTelefonoAdd']
        cursor.execute('INSERT INTO empresas (nombre, tipo, ubicacion, correo, telefono) VALUES (%s, %s, %s, %s, %s)', (nombre, tipo, ubicacion, correo, telefono))
        mysql.connection.commit()

        flash('SuccessEnterprise')
        return redirect(url_for('listaEmpresas'))

@app.route('/editarEmpresa/<id>', methods=['POST'])
def updateEmpresa(id):
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        nombre = request.form['txtNombreEdit']
        tipo = request.form['txtTipoEdit']
        ubicacion = request.form['txtUbicacionEdit']
        correo = request.form['txtCorreoEdit']
        telefono = request.form['intTelefonoEdit']
        cursor.execute('UPDATE empresas SET nombre=%s, tipo=%s, ubicacion=%s, correo=%s, telefono=%s WHERE id=%s', (nombre, tipo, ubicacion, correo, telefono, [id]))
        mysql.connection.commit()

        flash('AlertEnterprise')
        return redirect(url_for('listaEmpresas'))
    
@app.route('/eliminarEmpresa/<id>', methods=['POST'])
def deleteEmpresa(id):
    cursor = mysql.connection.cursor()
    cursor.execute('DELETE FROM empresas WHERE id=%s', ([id]))
    mysql.connection.commit()

    flash('DeleteEnterprise')
    return redirect(url_for('listaEmpresas'))

# PUNTOS DE RECOLECCION ----------------------------------------------------------------------------------------------------
@app.route('/puntosRecoleccion')
def puntosRecoleccion():
    try:
        cursor = mysql.connection.cursor()
        cursor.execute('SELECT * FROM puntos_recoleccion')
        data = cursor.fetchall()
        cursor.close()
        
        cursor = mysql.connection.cursor()
        cursor.execute('SELECT hr.id_puntoRecoleccion, pr.nombre, hr.dia, pr.hora_inicio, pr.hora_final FROM puntos_recoleccion pr INNER JOIN horarios_recoleccion hr ON pr.id = hr.id_puntoRecoleccion')
        times = cursor.fetchall()
        cursor.close()
        
        return render_template('vistas/puntosRecoleccion.html', puntos=data, horarios=times)
    
    except Exception as e:
        print(e)
        return 'Error al obtener los puntos de recolección'

@app.route('/agregarPunto', methods=['POST'])
def insertPunto():
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        nombre = request.form['txtNombreAdd']
        ubicacion = request.form['txtUbicacionAdd']
        hora_inicio = request.form['timeHoraInicioAdd']
        hora_final = request.form['timeHoraFinalAdd']
        dias = request.form['txtDiasAdd']
        cursor.execute('INSERT INTO puntos_recoleccion (nombre, ubicacion, hora_inicio, hora_final, dias) VALUES (%s, %s, %s, %s, %s)', (nombre, ubicacion, hora_inicio, hora_final, dias))
        mysql.connection.commit()
        
        flash('SuccessPoint')
        return redirect(url_for('puntosRecoleccion'))
    
@app.route('/editarPunto/<id>', methods=['POST'])
def updatePunto(id):
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        nombre = request.form['txtNombreEdit']
        ubicacion = request.form['txtUbicacionEdit']
        hora_inicio = request.form['timeInicioEdit']
        hora_final = request.form['timeFinalEdit']
        dias = request.form['txtDiasEdit']
        cursor.execute('UPDATE puntos_recoleccion SET nombre=%s, ubicacion=%s, hora_inicio=%s, hora_final=%s, dias=%s WHERE id=%s', (nombre, ubicacion, hora_inicio, hora_final, dias, [id]))
        mysql.connection.commit()

        flash('AlertPoint')
        return redirect(url_for('puntosRecoleccion'))

@app.route('/eliminarPunto/<id>', methods=['POST'])
def deletePunto(id):
    cursor = mysql.connection.cursor()
    cursor.execute('DELETE FROM puntos_recoleccion WHERE id=%s', ([id]))
    mysql.connection.commit()

    flash('DeletePoint')
    return redirect(url_for('puntosRecoleccion'))

# RECOLECCIONES ------------------------------------------------------------------------------------------------------------
@app.route('/misRecolecciones')
def misRecolecciones():
    return render_template('misRecolecciones.html')


# APP ------------------------------------------------------------------------------------------------------------
@app.errorhandler(404)
def paginaerror(e):
    return 'Revisa tu sintaxis: No encontré la página especificada'

if __name__ == '__main__':
    app.run(port=3000, debug=True)