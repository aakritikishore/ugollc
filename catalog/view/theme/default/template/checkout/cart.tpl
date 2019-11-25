<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($attention) { ?>
  <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?>
        <?php if ($weight) { ?>
        &nbsp;(<?php echo $weight; ?>)
        <?php } ?>
      </h1>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="cart-form">
        <div class="table-responsive">
          <table class="table table-bordered">
            <thead>
              <tr>
                <td class="text-center"><?php echo $column_image; ?></td>
                <td class="text-left"><?php echo $column_name; ?></td>
                <td class="text-left"><?php echo $column_model; ?></td>
                <td class="text-left"><?php echo $column_quantity; ?></td>
                <td class="text-right"><?php echo $column_price; ?></td>
                <td class="text-right"><?php echo $column_total; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($products as $product) { ?>
              <tr>
                <td class="text-center"><?php if ($product['thumb']) { ?>
                  <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" /></a>
                  <?php } ?></td>
                <td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                  <?php if (!$product['stock']) { ?>
                  <span class="text-danger">***</span>
                  <?php } ?>
                  <?php if ($product['option']) { ?>
                  <?php foreach ($product['option'] as $option) { ?>
                  <br />
                  <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                  <?php } ?>
                  <?php } ?>
                  <?php if ($product['reward']) { ?>
                  <br />
                  <small><?php echo $product['reward']; ?></small>
                  <?php } ?>
                  <?php if ($product['recurring']) { ?>
                  <br />
                  <span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
                  <?php } ?></td>
                <td class="text-left"><?php echo $product['model']; ?></td>
                <td class="text-left"><div class="input-group btn-block" style="max-width: 200px;">
                    <input type="text" name="quantity[<?php echo $product['cart_id']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" class="form-control" />
                    <span class="input-group-btn">
                    <button type="submit" data-toggle="tooltip" title="<?php echo $button_update; ?>" class="btn btn-primary"><i class="fa fa-refresh"></i></button>
                    <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="cart.remove('<?php echo $product['cart_id']; ?>');"><i class="fa fa-times-circle"></i></button>
					</span></div></td>
                <td class="text-right chkprice"><?php echo $product['price']; ?></td>
                <td class="text-right chkprice"><?php echo $product['total']; ?></td>
              </tr>
              <?php } ?>
             <?php foreach ($credits as $credit) { ?> 
             <tr> 
                 <td class="text-center">
                     <?php if ($credit_image) { ?> 
                        <img src="<?php echo $credit_image; ?>" alt="<?php echo $credit['description']; ?>" title="<?php echo $credit['description']; ?>" class="img-thumbnail" /> 
                        <?php } ?>
                 </td> 
                 <td class="text-left">
                     <?php echo $credit['description']; ?>
                 </td> <td class="text-left"></td> 
                 <td class="text-left">
                     <div class="input-group btn-block" style="max-width: 200px;"> 
                         <input type="text" name="" value="1" size="1" disabled="disabled" class="form-control" /> <span class="input-group-btn"> 
                             <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="credit.remove('<?php echo $credit['key']; ?>');"><i class="fa fa-times-circle"></i>
                             </button> </span></div></td> <td class="text-right"><?php echo $credit['amount']; ?>
                 </td> 
                 <td class="text-right">
                     <?php echo $credit['amount']; ?>
                 </td> 
             </tr> 
             <?php } ?> 
              <?php foreach ($vouchers as $voucher) { ?>
              <tr>
                <td></td>
                <td class="text-left"><?php echo $voucher['description']; ?></td>
                <td class="text-left"></td>
                <td class="text-left"><div class="input-group btn-block" style="max-width: 200px;">
                    <input type="text" name="" value="1" size="1" disabled="disabled" class="form-control" />
                    <span class="input-group-btn">
                    <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="voucher.remove('<?php echo $voucher['key']; ?>');"><i class="fa fa-times-circle"></i></button>
                    </span></div></td>
                <td class="text-right"><?php echo $voucher['amount']; ?></td>
                <td class="text-right"><?php echo $voucher['amount']; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        </div>
      </form>
      <?php if ($modules) { ?>
	  <div class="row">
	    <div class="col-sm-12">
		<h2><?php echo $text_next; ?></h2>
		<p><?php echo $text_next_choice; ?></p>
		</div>
		<div class="panel-group col-sm-8" id="accordion">
		<?php foreach ($modules as $module) { ?>
        <?php echo $module; ?>
        <?php } ?>
		</div>
		<?php } ?>
		<div class="col-sm-4 sub-total-table">
		<table class="table table-bordered">
			<?php foreach ($totals as $total) { ?>
			<tr>
			  <td class="text-right heading-title"><strong><?php echo $total['title']; ?>:</strong></td>
			  <td class="text-right total-amount"><?php echo $total['text']; ?></td>
			</tr>
			<?php } ?>
		  </table>
		</div>
	  </div>
	  <div class="buttons btn-checkout">
        <div class="pull-left"><a href="<?php echo $continue; ?>" class="btn btn-default"><?php echo $button_shopping; ?></a></div>
        <div class="pull-right"><a href="<?php echo $checkout; ?>" class="btn btn-primary"><?php echo $button_checkout; ?></a></div>
      </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<script type="text/javascript"> <!-- var credit = { 'add': function() { }, 'remove': function(key) { $.ajax({ url: 'index.php?route=checkout/cart/remove', type: 'post', data: 'key=' + key, dataType: 'json', beforeSend: function() { $('#cart > button').button('loading'); }, complete: function() { $('#cart > button').button('reset'); }, success: function(json) { // Need to set timeout otherwise it wont update the total setTimeout(function () { $('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>'); }, 100); if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') { location = 'index.php?route=checkout/cart'; } else { $('#cart > ul').load('index.php?route=common/cart/info ul li'); } }, error: function(xhr, ajaxOptions, thrownError) { alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText); } }); } } --> </script> 
<?php echo $footer; ?> 