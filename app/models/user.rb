# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string(128)      default(""), not null
#  admin                  :boolean          default(FALSE)
#  language               :string(255)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  roles                  :string(255)      default("--- []")
#  volunteer_id           :integer
#  avatar                 :string(255)
#

class User < ApplicationRecord
	
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
  
  validates :volunteer_id, presence: true

  belongs_to :volunteer
  
  mount_uploader :avatar, ImageUploader

end
