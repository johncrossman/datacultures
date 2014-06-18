require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe PointsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Point. As you add validations to Point, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {uid: "FOO", reason: "liked", delta: 1}
  }

  let(:invalid_attributes) {
    {uid: "BAR", reason: 3 }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PointsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all points as @points" do
      expect(valid_attributes).to eq({:uid => 'FOO', :reason => 'liked', :delta => 1})
      point = Point.create! valid_attributes
      get :index, {format: :json}, valid_session
      expect(assigns(:points)).to eq([point])
    end
  end

  describe "GET show" do
    it "assigns the requested point as @point" do
      point = Point.create! valid_attributes
      get :show, {id:  point.to_param, format:  :json}, valid_session
      expect(assigns(:point)).to eq(point)
    end

    it "returns not found for a non-existent point" do
      get :show, {id: "DOES NOT EXIST", format: :json}, valid_session
      expect(response.status).to eq(204)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Point" do
        expect {
          post :create, {point:  valid_attributes, format: :json}, valid_session
        }.to change(Point, :count).by(1)
      end

      it "assigns a newly created point as @point" do
        post :create, {point: valid_attributes, format: :json}, valid_session
        expect(assigns(:point)).to be_a(Point)
        expect(assigns(:point)).to be_persisted
      end

      it "renders the created point" do
        post :create, {point: valid_attributes, format: :json}, valid_session
        expect(response.body).to eq(Point.last.to_json)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved point as @point" do
        post :create, {point: invalid_attributes, format: :json}, valid_session
        expect(assigns(:point)).to be_a_new(Point)
      end
    end
  end

  describe "PUT update (logical delete)" do
    describe "with valid params" do

      it "updates the requested point" do
        point = Point.create! valid_attributes
        put :update, {id: point.to_param}, valid_session
        point.reload
        expect(point.deleted_at).to_not be_nil
      end

      it "returns no content after deleting a point" do
        point = Point.create! valid_attributes
        put :update, {id: point.to_param }, valid_session
        expect(response.status).to eq(204)
      end

    end

    describe "with invalid params" do

      it "returns 'no content' if the point does not exist " do
        put :update, {id: "NONEXISTENT"}, valid_session
        expect(response.status).to eq(422)
      end

    end
  end



end