class Public::HomesController < Public::ApplicationController
  def top
    @genres = Genre.all
  end
end
