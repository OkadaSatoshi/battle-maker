class BattlesController < ApplicationController
  before_action :set_battle, only:[:show, :edit, :update, :destroy]
  
  def index
    @battles = Battle.all.order("battle_date DESC")
  end
  
  def new
    if params[:back]
      @battle = Battle.new(battle_params)
    else
      @battle = Battle.new
    end
  end
    
  def create
    @battle = Battle.new(battle_params)
    @battle.user_id = current_user.id
    @battle.save
    redirect_to battles_path
  end
  
  def show
    @joined = current_user.participant_managements.find_by(battle_id: @battle.id)
    @comment = @battle.comments.build
    @comments = @battle.comments
  end
  
  def edit
  end
  
  def update
    @battle.update(battle_params)
    redirect_to battles_path
  end
  
  def destroy
    @battle.destroy
    redirect_to battles_path
  end
    
  
  
  private
  def battle_params
    params.require(:battle).permit(:title, :content, :place, :battle_date, :user_id)
  end
  
  def set_battle
    @battle = Battle.find(params[:id])
  end
end
