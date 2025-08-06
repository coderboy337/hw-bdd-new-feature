require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  let!(:movie_with_director) { Movie.create(title: "Star Wars", director: "George Lucas") }
  let!(:movie_without_director) { Movie.create(title: "Alien", director: "") }
  let!(:other_movie) { Movie.create(title: "THX-1138", director: "George Lucas") }

  describe "GET #show_by_director" do
    context "when the movie has a director" do
      it "assigns movies with the same director" do
        get :show_by_director, params: { id: movie_with_director.id }
        expect(assigns(:movies)).to include(movie_with_director, other_movie)
        expect(assigns(:movies)).not_to include(movie_without_director)
        expect(response).to render_template(:show_by_director)
      end
    end

    context "when the movie has no director" do
      it "redirects to movies path with flash message" do
        get :show_by_director, params: { id: movie_without_director.id }
        expect(response).to redirect_to(movies_path)
        expect(flash[:notice]).to eq("'#{movie_without_director.title}' has no director info")
      end
    end

    context "when the movie id is invalid" do
      it "raises ActiveRecord::RecordNotFound error" do
        expect {
          get :show_by_director, params: { id: 9999 }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "PUT #update" do
    it "updates movie director" do
      put :update, params: { id: movie_without_director.id, movie: { director: "Ridley Scott" } }
      movie_without_director.reload
      expect(movie_without_director.director).to eq("Ridley Scott")
      expect(response).to redirect_to(movie_path(movie_without_director))
      expect(flash[:notice]).to be_present
    end

    it "renders edit on invalid update" do
      allow_any_instance_of(Movie).to receive(:update).and_return(false)
      put :update, params: { id: movie_without_director.id, movie: { director: "" } }
      expect(response).to render_template(:edit)
    end
  end

  # Add more tests for other actions if needed...
end
