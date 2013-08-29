class TransactionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @transactions = current_user.transactions
    @transaction = current_user.transactions.new
  end

  def create
    transaction = current_user.transactions.build(params[:transaction])

    if transaction.save
      @transaction = current_user.transactions.build
      @transactions = current_user.transactions
      redirect_to transactions_path
    else

      flash[:alert] = "Record couldn't be saved"
      @transactions = current_user.transactions
      @transaction = current_user.transactions.build
      render :index
    end
  end
end
