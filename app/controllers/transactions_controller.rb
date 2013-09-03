class TransactionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @revenues = current_user.transactions.where(transaction_type: true).order("date desc")
    @expenses = current_user.transactions.where(transaction_type: false).order("date desc, category_id, value_cents desc")
    @transaction = current_user.transactions.build
    @category = current_user.categories.build
  end

  def create
    transaction_hash = Transaction.createTransaction(params[:transaction], current_user)
    transaction = current_user.transactions.build(transaction_hash)
    
    if transaction_hash == nil
      @transaction = current_user.transactions.build
      @revenues = current_user.transactions.where(transaction_type: true)
      @expenses = current_user.transactions.where(transaction_type: false)
      @category = current_user.categories.build
      flash[:alert] = "Record couldn't be saved"
      respond_to do |format|
        format.html {render :index}
        format.js
      end
    
    elsif transaction.save 
      @transaction = current_user.transactions.build
      @revenues = current_user.transactions.where(transaction_type: true)
      @expenses = current_user.transactions.where(transaction_type: false)
      @category = current_user.categories.build

      respond_to do |format|
        format.html {redirect_to transactions_path}
        format.js
      end
      
    else

      flash[:alert] = "Record couldn't be saved"
      @revenues = current_user.transactions.where(transaction_type: true)
      @expenses = current_user.transactions.where(transaction_type: false)
      @category = current_user.categories.build
      @transaction = transaction
      respond_to do |format|
        format.html {render :index}
        format.js
      end
      
    end
  end

  
  def destroy
    transaction = Transaction.find(params[:id])
    transaction.destroy
    @transaction = current_user.transactions.build
    @revenues = current_user.transactions.where(transaction_type: true)
    @expenses = current_user.transactions.where(transaction_type: false)
    @category = current_user.categories.build
    respond_to do |format|
      format.html {redirect_to transactions_path}
      format.js 
    end
  end
end
