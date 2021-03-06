require 'rails_helper'

RSpec.describe UsersController, :users => true, type: :controller do
  render_views
  
  # Lazy loading of upper model
  let (:vol1) { FactoryBot.create(:volunteer, :vol) }
  let (:vol2) { FactoryBot.create(:volunteer, :vol) }
  let (:vol3) { FactoryBot.create(:volunteer, :vol) }

  let(:user) { FactoryBot.create(:user, :normal, volunteer_id: vol1.id) }
  let(:valid_attributes) { FactoryBot.attributes_for(:user) }
  let(:second_user) { FactoryBot.create(:user, :normal, volunteer_id: vol2.id) }
  let(:user_admin) { FactoryBot.create(:user, :admin, volunteer_id: vol3.id) }
  
  it { is_expected.to use_before_action(:authenticate_user!) }
  pending "specs for flash messages"
  
  describe "removes devise routes for registrations" do
    # only added tests for some of them, not all
    it { is_expected.not_to route(:get, '/d/users/cancel').to(controller: "devise/registrations", action: :cancel)}
    it { is_expected.not_to route(:get, '/d/users/sign_up').to(controller: "devise/registrations", action: :new)}
    it { is_expected.not_to route(:get, '/d/users/edit').to(controller: "devise/registrations", action: :edit)}
    it { is_expected.not_to route(:post, '/d/users').to(controller: "devise/registrations", action: :create)}
  end

  describe "index" do
    it "exists as a method in the controller" do
      expect(subject).to respond_to(:index)
    end
    it { is_expected.to use_before_action(:admin_user) } 
    context "authenticated" do
      context "as admin user" do
        before(:each) do
          sign_in user_admin
          get :index
        end

        it { should route(:get, '/users').to(action: :index) }
        it { is_expected.to render_template('index') }  
        it { is_expected.to respond_with(200) }
      end   
      context "as normal user" do
        before(:each) do
          sign_in user
          get :index
        end
        it { should route(:get, '/').to(controller: :pages, action: :home) }
        it { is_expected.to redirect_to('/') } 
        it { is_expected.to respond_with(302) }
      end
    end
    context "as a guest" do
      before(:each) do
        get :index
      end
      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to "/" }
      #it "redirects to the sign-in page" do
      #  expect(response).to redirect_to "/"
      #end
    end
  end

  describe "show" do
    it "exists as a method in the controller" do
      expect(subject).to respond_to(:show)
    end
    context "authenticated" do
      it { is_expected.to use_before_action(:correct_user) }
      context "admin user" do
        before(:each) do
          sign_in user_admin
          get :show, params: { id: user_admin.id }
        end
        context "own profile" do
          it { should route(:get, "/users/#{user_admin.id}").to(action: :show, id: user_admin.id) }
          it { is_expected.to render_template('show') }
          it { is_expected.to respond_with(200) }
        end
        context "other user profile" do
          before(:each) do
            get :show, params: { id: second_user.id }
          end
          it { should route(:get, "/users/#{second_user.id}").to(action: :show, id: second_user.id) }
          it { is_expected.to render_template('show') } 
          it { is_expected.to respond_with(200) }
        end
      end
      context "normal user" do
        before(:each) do
          sign_in user
          get :show, params: { id: user.id }
        end
        context "own profile" do
          it { should route(:get, "/users/#{user.id}").to(action: :show, id: user.id) }
          # FIXME
          xit { is_expected.to render_template('show') }  
          xit { is_expected.to respond_with(200) }
        end
        context "other user profile" do
          before(:each) do
            get :show, params: { id: second_user.id }
          end
          it { is_expected.to redirect_to('/') } 
          it { is_expected.to respond_with(302) }
        end
      end
    end
    context "as a guest" do
      before(:each) do
        get :show, params: { id: user.id }
      end
      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to "/" }
    end
  end  

  describe "new" do
    it "exists as a method in the controller" do
      expect(subject).to respond_to(:new)
    end
    it { is_expected.to use_before_action(:admin_user) } 
    context "authenticated" do
      context "admin user" do
        before(:each) do
          sign_in user_admin
          get :new
        end
        it { is_expected.to route(:get, "/users/new").to(action: :new) }
        it { is_expected.to render_template('new') }
        it { is_expected.to respond_with(200) }
      end
      context "normal user" do
        before(:each) do
          sign_in user
          get :new
        end
        it { should route(:get, "/users/new").to(action: :new) }
        it { is_expected.to redirect_to('/') }
        it { is_expected.to respond_with(302) }
      end
    end
    context "as a guest" do
      before(:each) do
        get :new
      end
      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to "/" }
    end
  end

  describe "create" do
    it "exists as a method in the controller" do
      expect(subject).to respond_to(:create)
    end
    it { is_expected.to use_before_action(:admin_user) } 
    context "authenticated as" do
      context "admin user" do
        before(:each) do
          @params = { user: { name: second_user.name, email: second_user.email, password: second_user.password } }
          sign_in user_admin
          post :create, params: @params 
        end
        # FIXME
        it { is_expected.to route(:post, "/users").to(action: :create) }
        it do
          should permit(:name, :password, :email).
            for(:create, params: @params )
        end
        it { is_expected.to render_template('new') }
        pending "set flash"
        it { is_expected.to respond_with(200) }
      end
      context "normal user" do
        before(:each) do
          @params = { user: { name: second_user.name, email: second_user.email, password: second_user.password, volunteer_id: second_user.volunteer_id } }
          sign_in user
          post :create, params: @params 
        end
        it { is_expected.to redirect_to('/') }
        it { is_expected.to respond_with(302) }
      end
    end
    context "as guest" do
      before(:each) do
        post :create, params: @params 
      end
      # FIXME
      xit { is_expected.to redirect_to('/d/users/sign_in') }
      xit { is_expected.to respond_with(302) }
    end    
  end
  
  describe "edit" do
    it "exists as a method in the controller" do
      expect(subject).to respond_to(:edit)
    end
    it { is_expected.to use_before_action(:correct_user) } 
    context "authenticated as" do
      pending "admin user"
      context "normal user" do  
        context "own profile" do
          before(:each) do
           sign_in user
           get :edit, params: { id: user.id }
          end
          it { should route(:get, "/users/#{user.id}/edit").to(action: :edit, id: user.id) }
          it { is_expected.to respond_with(302) }
          # FIXME
          xit { is_expected.to render_template('edit') }
        end
        context "other profiles" do
          before(:each) do
           sign_in user
           get :edit, params: { id: second_user.id }
          end
          it { is_expected.to redirect_to('/') }
          it { is_expected.to respond_with(302) }
        end
      end
    end
    context "as a guest" do
      before(:each) do
        get :edit, params: { id: user.id }
      end
      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to "/" }
    end
  end

  describe "update" do
    it "exists as a method in the controller" do
      expect(subject).to respond_to(:update)
    end
    context "authenticated as" do
      context "admin user" do
        before(:each) do
          @params = { user: { name: second_user.name, email: second_user.email, password: second_user.password } }
          sign_in user_admin
          patch :update, params: { id: second_user.id, user: @params }
        end
        it { is_expected.to route(:patch, "/users/#{second_user.id}").to(action: :update, id: second_user.id) }
        it do
          should permit(:name, :password, :email).
            for(:create, params: @params )
        end
        it { is_expected.to redirect_to("/users/#{second_user.id}") }
        pending "set flash"
        it { is_expected.to respond_with(302) }
      end
    end
    context "normal user" do
      before(:each) do
        @params = { user: { name: second_user.name, email: second_user.email, password: second_user.password } }
        sign_in user
        patch :update, params: { id: second_user.id, user: @params }
      end  
      it { is_expected.to redirect_to("/") }
      it { is_expected.to respond_with(302) }
    end
    context "as guest" do
      before(:each) do 
        @params = { user: { name: second_user.name, email: second_user.email, password: second_user.password } }
        patch :update, params: { id: second_user.id, user: @params }
      end 
      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to "/" }
    end
  end

  describe "destroy" do
    it "exists as a method in the controller" do
      expect(subject).to respond_to(:destroy)
    end
    it { is_expected.to use_before_action(:admin_user) } 
    context "authenticated as" do      
      context "admin user" do
        context "own profile" do
          before(:each) do
            sign_in user_admin
#             puts "#{user_admin.inspect}"
          end
          pending "validate the users logs out"
          # FIXME
          it "user count should decrement by 1" do
            expect{
              delete :destroy, params: { id: user_admin.id }
              }.to change(User, :count).by(-1)
          end
        end
        context "other profile" do
          before(:each) do
            sign_in user_admin
            delete :destroy, params: { id: second_user.id }
          end          
          # FIXME
          it { is_expected.to redirect_to("/users") }
          it { is_expected.to respond_with(302) }
        end
      end
      context "normal user" do
        before(:each) do
          sign_in user
          delete :destroy, params: { id: user.id }
        end  
        # FIXME
        it { is_expected.to redirect_to("/") }
        it { is_expected.to respond_with(302) }
      end
    end
    context "as guest" do
      before(:each) do 
        @params = { user: { name: second_user.name, email: second_user.email, password: second_user.password } }
        patch :update, params: { id: second_user.id, user: @params }
      end 
      # FIXME
      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to "/" }
    end
  end
end