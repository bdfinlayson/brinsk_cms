describe TasksController do
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe '#index' do
    it 'success' do
      get :index
      expect(response).to render_template :index
    end
  end
end
