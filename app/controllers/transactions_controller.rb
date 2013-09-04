class TransactionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    load_session
    redirect_to filter_transactions_path({category: session[:category], date: session[:date], startDate: session[:startDate], endDate: session[:endDate]})
  end

  def create
    transaction_hash = Transaction.createTransaction(params[:transaction], current_user)
    transaction = current_user.transactions.build(transaction_hash)
    
    if transaction_hash == nil
      @transaction = current_user.transactions.build
      load_data
      flash[:alert] = "Record couldn't be saved"
      respond_to do |format|
        format.html {render :index}
        format.js
      end
    
    elsif transaction.save 
      @transaction = current_user.transactions.build
      load_data
      respond_to do |format|
        format.html {redirect_to transactions_path}
        format.js
      end
      
    else

      flash[:alert] = "Record couldn't be saved"
      load_data
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
    load_data
    respond_to do |format|
      format.html {redirect_to transactions_path}
      format.js 
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
    load_data
    respond_to do |format|
      format.html {redirect_to transactions_path}
      format.js 
    end
  end

  def add_category
    load_data
    @transaction = current_user.transactions.build
    current_user.addCategory(params[:category][:title], params[:category][:transaction_type])

    respond_to do |format|
      format.html {redirect_to transactions_path}
      format.js 
    end
  end

  def filter
    load_data
    @transaction = current_user.transactions.build
    p params
    @expenses = current_user.getExpenses(params)
    render :index
  end

  private 
  def load_data
    @revenues = current_user.transactions.where(transaction_type: true).order("date desc, category_id, value_cents desc")
    @expenses = current_user.transactions.where(transaction_type: false).order("date desc, category_id, value_cents desc")
    
    @total_expenses = Transaction.getTotal(@expenses)
    @total_revenues = Transaction.getTotal(@revenues)
    @category = current_user.categories.build
  end

  def load_session
    session[:filter_category] = params[:filter_category] if params[:filter_category]
    session[:date] = params[:date] ? params[:date] : "month"
    session[:startDate] = params[:startDate] if params[:startDate]
    session[:endDate] = params[:endDate] if params[:endDate]
    
  end
end
