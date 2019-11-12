<?php
class ControllerAccountReward extends Controller {
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/reward', '', true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}

		$this->load->language('account/reward');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('account/account', '', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_reward'),
			'href' => $this->url->link('account/reward', '', true)
		);

		$this->load->model('account/reward');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['column_date_added'] = $this->language->get('column_date_added');
		$data['column_description'] = $this->language->get('column_description');
		$data['column_points'] = $this->language->get('column_points');

		$data['text_total'] = $this->language->get('text_total');
		$data['text_empty'] = $this->language->get('text_empty');

		$data['button_continue'] = $this->language->get('button_continue');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['rewards'] = array();

		$filter_data = array(
			'sort'  => 'date_added',
			'order' => 'DESC',
			'start' => ($page - 1) * 10,
			'limit' => 10
		);

		$reward_total = $this->model_account_reward->getTotalRewards();

		$results = $this->model_account_reward->getRewards($filter_data);

		foreach ($results as $result) {
			$data['rewards'][] = array(
				'order_id'    => $result['order_id'],
				'points'      => $result['points'],
				'description' => $result['description'],
				'date_added'  => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'href'        => $this->url->link('account/order/info', 'order_id=' . $result['order_id'], true)
			);
		}

		$pagination = new Pagination();
		$pagination->total = $reward_total;
		$pagination->page = $page;
		$pagination->limit = 10;
		$pagination->url = $this->url->link('account/reward', 'page={page}', true);

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($reward_total) ? (($page - 1) * 10) + 1 : 0, ((($page - 1) * 10) > ($reward_total - 10)) ? $reward_total : ((($page - 1) * 10) + 10), $reward_total, ceil($reward_total / 10));

		$data['total'] = (int)$this->customer->getRewardPoints();

		$data['continue'] = $this->url->link('account/account', '', true);

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('account/reward', $data));
	}
        
        //Custom function for API to get Store Credit  :
        public function credit() {
            $data = array();
            $customer_id = $this->customer->getId();
            $this->load->model('checkout/buy_credit');
            $data['credit'] = $this->model_checkout_buy_credit->getTransactionTotal($customer_id);
            $this->response->addHeader('Content-Type: application/json');
            $this->response->setOutput($data);
	}
        
        //Custom function for API to get Store Credit via post method for older version of app  :
        public function credit_via_post() {
            $data = array();
            $customer_email = $this->request->post['customer_email']; 
            $customer_info = $this->getCustomer($customer_email);
            $query = $this->db->query("SELECT SUM(amount) AS total FROM " . DB_PREFIX . "customer_transaction WHERE customer_id = '" . (int)$customer_info['customer_id']. "'");
            $data['credit']= $query->row['total'];
            $this->response->addHeader('Content-Type: application/json');
            $this->response->setOutput($data);
	}
}