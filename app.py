from flask import Flask, request, render_template, jsonify, url_for, redirect, flash, request, Response, session
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'db'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'voo'
app.config['MYSQL_DB'] = 'ecommunity'
app.secret_key = 'your_secret_key'

mysql = MySQL(app)

# LOGIN - SESIONES ------------------------------------------------------------------------------------------------------------
@app.route('/')
@app.route('/login')
def login():
    if 'id' in session:
        if session['rol'] == 'Usuario':
            return redirect(url_for('misRecolecciones'))
        else:
            return redirect(url_for('homeAdmin'))
    return render_template('views/login.html')

@app.route('/access', methods=['POST'])
def access():
    if request.method == 'POST':
        correo = request.form['txtEmail']
        password = request.form['txtPassword']

        cursor = mysql.connection.cursor()
        cursor.callproc('SP_Login', (correo, password))
        account = cursor.fetchone()

        if account:
            session['id'] = account[0]
            session['nombre'] = account[1]
            session['correo'] = account[2]
            session['rol'] = account[5]
            cursor.close()
            if session['rol'] == 'Usuario':
                return redirect(url_for('misRecolecciones'))
            else:
                return redirect(url_for('homeAdmin'))
        else:
            flash('AccessError')
            return redirect(url_for('login'))

@app.route('/logout')
def logout():
    session.clear()
    print(session)
    return redirect(url_for('login'))

@app.route('/register')
def register():
    if 'id' in session:
        if session['rol'] == 'Usuario':
            return redirect(url_for('misRecolecciones'))
        else:
            return redirect(url_for('homeAdmin'))
    else:
        return render_template('views/register.html')

@app.route('/registerUser', methods=['POST'])
def registerUser():
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        nombre = request.form['txtNombre']
        correo = request.form['txtEmail']
        password = request.form['txtPassword']
        confirm = request.form['txtPasswordConfirmation']
        ubicacion = request.form['txtUbicacion']
        if password != confirm:
            flash('PasswordError')
            return redirect(url_for('register'))
        else:
            cursor.callproc('SP_InsertUsuario', (nombre, correo, password, ubicacion, 'Usuario'))
            mysql.connection.commit()
            flash('SuccessRegister')
            return redirect(url_for('login'))

@app.route('/home')
def homeAdmin():
    return render_template('views/homeAdmin.html')


# USUARIOS ------------------------------------------------------------------------------------------------------------
@app.route('/listaUsuarios')
def listaUsuarios():
    if session:
        try:
            cursor = mysql.connection.cursor()
            cursor.callproc('SP_SelectUsuarios')
            data = cursor.fetchall()
            cursor.close()
            cursor = mysql.connection.cursor()
            cursor.callproc('SP_Select_Usuarios_Recientes')
            recent = cursor.fetchall()
            cursor.close()
            return render_template('views/listaUsuarios.html', usuarios=data, recientes=recent)
        except Exception as e:
            print(e)
            return 'Error al obtener los usuarios'
    else:
        return redirect(url_for('login'))
    
@app.route('/agregarUsuario', methods=['POST'])
def insertUsuario():
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        nombre = request.form['txtNombreAdd']
        correo = request.form['txtCorreoAdd']
        password = request.form['txtPasswordAdd']
        ubicacion = request.form['txtUbicacionAdd']
        rol = request.form['txtRolAdd']
        cursor.callproc('SP_InsertUsuario', (nombre, correo, password, ubicacion, rol))
        mysql.connection.commit()

        flash('SuccessAdd')
        return redirect(url_for('listaUsuarios'))

@app.route('/editarUsuario/<id>', methods=['POST'])
def updateUsuario(id):
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        nombre = request.form['txtNombreEdit']
        correo = request.form['txtCorreoEdit']
        password = request.form['txtPasswordEdit']
        ubicacion = request.form['txtUbicacionEdit']
        rol = request.form['txtRolEdit']
        cursor.callproc('SP_UpdateUsuario', (nombre, correo, password, ubicacion, rol, [id]))
        mysql.connection.commit()

        flash('SuccessEdit')
        return redirect(url_for('listaUsuarios'))

@app.route('/eliminarUsuario/<id>', methods=['POST'])
def deleteUsuario(id):
    cursor = mysql.connection.cursor()
    cursor.callproc('SP_DeleteUsuario', ([id]))
    mysql.connection.commit()

    flash('SuccessDelete')
    return redirect(url_for('listaUsuarios'))


# EMPRESAS ------------------------------------------------------------------------------------------------------------
@app.route('/listaEmpresas')
def listaEmpresas():
    if session:
        try:
            cursor = mysql.connection.cursor()
            cursor.callproc('SP_SelectEmpresas')
            data = cursor.fetchall()
            cursor.close()
            cursor = mysql.connection.cursor()
            cursor.callproc('SP_Select_Empresas_Recientes')
            recent = cursor.fetchall()
            cursor.close()
            cursor = mysql.connection.cursor()
            cursor.callproc('SP_Select_Tipos_Reciclajes_Empresas')
            types = cursor.fetchall()
            cursor.close()
            return render_template('views/listaEmpresas.html', empresas=data, recientes=recent, tipos=types)
        except Exception as e:
            print(e)
            return 'Error al obtener las empresas'
    else:
        return redirect(url_for('login'))

@app.route('/agregarEmpresa', methods=['POST'])
def insertEmpresa():
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        nombre = request.form['txtNombreAdd']
        ubicacion = request.form['txtUbicacionAdd']
        correo = request.form['txtCorreoAdd']
        telefono = request.form['intTelefonoAdd']
        cursor.execute('SELECT F_InsertEmpresa(%s, %s, %s, %s)', (nombre, ubicacion, correo, telefono))
        id = cursor.fetchone()[0]
        mysql.connection.commit()
        cursor.close()

        cursor = mysql.connection.cursor()
        for i in range(1, 11):
            if request.form.get('check'+str(i)):
                validation = True
                tipo = request.form.get('check'+str(i))
                cursor.callproc('SP_Insert_Tipos_Reciclaje_Empresa', (tipo, id))
                mysql.connection.commit()
        cursor.close()
        if validation:
            flash('SuccessAdd')
            return redirect(url_for('listaEmpresas'))
        else:
            flash('ErrorAdd')
            return redirect(url_for('listaEmpresas'))


@app.route('/editarEmpresa/<id>', methods=['POST'])
def updateEmpresa(id):
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        nombre = request.form['txtNombreEdit']
        ubicacion = request.form['txtUbicacionEdit']
        correo = request.form['txtCorreoEdit']
        telefono = request.form['intTelefonoEdit']
        cursor.callproc('SP_UpdateEmpresa', (nombre, ubicacion, correo, telefono, [id]))
        mysql.connection.commit()
        cursor.close()

        cursor = mysql.connection.cursor()
        for i in range(1, 11):
            if request.form.get('editcheck'+str(i)):
                validation = True
                tipo = request.form.get('editcheck'+str(i))
                cursor.callproc('SP_Insert_Tipos_Reciclaje_Empresa', (tipo, id))
                mysql.connection.commit()
        cursor.close()
        if validation:
            flash('SuccessEdit')
            return redirect(url_for('listaEmpresas'))
        else:
            flash('ErrorEdit')
            return redirect(url_for('listaEmpresas'))
    
@app.route('/eliminarEmpresa/<id>', methods=['POST'])
def deleteEmpresa(id):
    cursor = mysql.connection.cursor()
    cursor.callproc('SP_DeleteEmpresa', ([id]))
    mysql.connection.commit()

    flash('SuccessDelete')
    return redirect(url_for('listaEmpresas'))

# PUNTOS DE RECOLECCION ----------------------------------------------------------------------------------------------------
@app.route('/puntosRecoleccion')
def puntosRecoleccion():
    if session:
        try:
            cursor = mysql.connection.cursor()
            cursor.callproc('SP_SelectPuntosRecoleccion')
            data = cursor.fetchall()
            cursor.close()
            cursor = mysql.connection.cursor()
            cursor.callproc('SP_Select_Horarios_Puntos_Recoleccion')
            times = cursor.fetchall()
            cursor.close()
            return render_template('views/puntosRecoleccion.html', puntos=data, horarios=times)
        except Exception as e:
            print(e)
            return 'Error al obtener los puntos de recolección'
    else:
        return redirect(url_for('login'))

@app.route('/agregarPunto', methods=['POST'])
def insertPunto():
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        nombre = request.form['txtNombreAdd']
        ubicacion = request.form['txtUbicacionAdd']
        cursor.execute('SELECT F_InsertPuntoRecoleccion(%s, %s)', (nombre, ubicacion))
        mysql.connection.commit()
        id = cursor.fetchone()[0]
        cursor.close()

        cursor = mysql.connection.cursor()
        for i in range(1, 8):
            if request.form.get('check'+str(i)):
                validation = True
                dia = request.form.get('check'+str(i))
                hora_inicio = request.form['timeStart'+str(i)]
                hora_final = request.form['timeEnd'+str(i)]
                if hora_inicio != '' and hora_final != '': 
                    filledInputs = True
                    cursor.callproc('SP_Insert_Horarios_Recoleccion', (hora_inicio, hora_final, dia, id))
                    mysql.connection.commit()
                else:
                    filledInputs = False
                    cursor.callproc('SP_DeleteHorarios', ([id]))
                    mysql.connection.commit()
                    cursor.callproc('SP_DeletePuntosRecoleccion', ([id]))
                    mysql.connection.commit()
                    break
        cursor.close()

        if validation and filledInputs:
            flash('SuccessAdd')
            return redirect(url_for('puntosRecoleccion'))
        else:
            flash('ErrorAdd')
            return redirect(url_for('puntosRecoleccion'))
    
@app.route('/editarPunto/<id>', methods=['POST'])
def updatePunto(id):
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        nombre = request.form['txtNombreEdit']
        ubicacion = request.form['txtUbicacionEdit']
        cursor.callproc('SP_UpdatePuntoRecoleccion', (nombre, ubicacion, [id]))
        mysql.connection.commit()
        cursor.close()

        validation = False
        for i in range(1, 8):
            if request.form.get('check'+str(i)):
                validation = True
                hora_inicio = request.form['timeStart'+str(i)]
                hora_final = request.form['timeEnd'+str(i)]
                if hora_inicio != '' and hora_final != '': 
                    filledInputs = True
                else:
                    filledInputs = False
                    break

        if validation and filledInputs:
            cursor = mysql.connection.cursor()
            cursor.callproc('SP_DeleteHorarios', ([id]))
            mysql.connection.commit()
            cursor.close()

            cursor = mysql.connection.cursor()
            for i in range(1, 8):
                if request.form.get('check'+str(i)):
                    dia = request.form.get('check'+str(i))
                    hora_inicio = request.form['timeStart'+str(i)]
                    hora_final = request.form['timeEnd'+str(i)]
                    cursor.callproc('SP_Insert_Horarios_Recoleccion', (hora_inicio, hora_final, dia, id))
                    mysql.connection.commit()
            cursor.close()
            flash('SuccessEdit')
            return redirect(url_for('puntosRecoleccion'))
        else:
            flash('ErrorEdit')
            return redirect(url_for('puntosRecoleccion'))

@app.route('/eliminarPunto/<id>', methods=['POST'])
def deletePunto(id):
    cursor = mysql.connection.cursor()
    cursor.callproc('SP_DeletePuntosRecoleccion', ([id]))
    mysql.connection.commit()

    flash('SuccessDelete')
    return redirect(url_for('puntosRecoleccion'))

# RECOLECCIONES ------------------------------------------------------------------------------------------------------------
@app.route('/misRecolecciones')
def misRecolecciones():
    if session:
        try:
            cursor = mysql.connection.cursor()
            id = session['id']
            cursor.callproc('SP_SelectRecoleccionesUsuario', ([id]))
            data = cursor.fetchall()
            cursor.close()
            cursor = mysql.connection.cursor()
            cursor.callproc('SP_SelectPuntosRecoleccion')
            points = cursor.fetchall()
            cursor.close()
            return render_template('views/misRecolecciones.html', recolecciones=data, puntos=points)
        except Exception as e:
            print(e)
            return 'Error al obtener las recolecciones'
    else:
        return redirect(url_for('login'))

@app.route('/agregarRecoleccion', methods=['POST'])
def agregarRecoleccion():
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        tipo = request.form['txtTipoAdd']
        idPuntoRecoleccion = request.form['idPuntoAdd']
        dia = request.form['txtDiaAdd']
        hora = request.form['txtHoraAdd']
        cantidad = request.form['floatCantidadAdd']
        id = session['id']
        cursor.callproc('SP_InsertRecoleccion', (tipo, dia, hora, cantidad, 'Pendiente', idPuntoRecoleccion, id))
        mysql.connection.commit()
        
        flash('SuccessAdd')
        return redirect(url_for('misRecolecciones'))

@app.route('/editarRecoleccion/<id>', methods=['POST'])
def editarRecoleccion(id):
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        tipo = request.form['txtTipoEdit']
        idPuntoRecoleccion = request.form['idPuntoEdit']
        dia = request.form['txtDiaEdit']
        hora = request.form['txtHoraEdit']
        cantidad = request.form['floatCantidadEdit']
        cursor.callproc('SP_UpdateRecoleccion', (tipo, dia, hora, cantidad, idPuntoRecoleccion, [id]))
        mysql.connection.commit()

        flash('SuccessEdit')
        return redirect(url_for('misRecolecciones'))

@app.route('/eliminarRecoleccion/<id>', methods=['POST'])
def eliminarRecoleccion(id):
    cursor = mysql.connection.cursor()
    cursor.callproc('SP_DeleteRecoleccion', ([id]))
    mysql.connection.commit()

    flash('SuccessDelete')
    return redirect(url_for('misRecolecciones'))


# APP ------------------------------------------------------------------------------------------------------------
@app.errorhandler(404)
def paginaerror(e):
    return 'Revisa tu sintaxis: No encontré la página especificada'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)