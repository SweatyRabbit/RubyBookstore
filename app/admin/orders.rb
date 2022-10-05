# frozen_string_literal: true

ActiveAdmin.register Order do
  decorate_with OrderDecorator
  permit_params :created_at, :order_state, :delivery_type
  actions :index, :show

  scope :in_progress, default: true
  scope :in_queue
  scope :delivered
  scope :canceled

  index do
    selectable_column
    column :id
    column :humanized_state
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :humanized_state
      row :created_at
      row :delivery_type
    end
  end

  batch_action I18n.t('activeadmin.orders.in_delivery_state'),
               if: proc { @current_scope.scope_method == :in_progress || :in_queue } do |ids|
    Order.in_progress.where(id: ids).each(&:in_delivery_step!)
    redirect_to(admin_orders_path)
  end

  batch_action I18n.t('activeadmin.orders.delivered_state'),
               if: proc { @current_scope.scope_method == :in_progress } do |ids|
    Order.in_progress.where(id: ids).each do |order|
      order.update(completed_at: Time.zone.now)
      order.delivered_step!
    end
    redirect_to(admin_orders_path)
  end

  batch_action I18n.t('activeadmin.orders.canceled_state'),
               if: proc { @current_scope.scope_method == :in_progress } do |ids|
    Order.in_progress.where(id: ids).each(&:canceled_step!)
    redirect_to(admin_orders_path)
  end
end
