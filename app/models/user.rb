class User < ActiveRecord::Base
	
  # Roles de usuarios
  easy_roles :roles
  # ---- Roles activos ----
  # 1. ss = Servicio Social
  # 2. oficina = Oficina
  # 3. timereport = Reporte de Tiempo
  # 4. managetimereport = Administrar reportes de tiempo
  # 5. managedonor = Administrar donadores
  # 6. managecontact = Administrar contactos
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :timeoutable, :validatable
  
  belongs_to :volunteer
  
  mount_uploader :avatar, ImageUploader

end