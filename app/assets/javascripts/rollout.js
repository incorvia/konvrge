/*
 * SimpleModal rollout Style Modal Dialog
 * http://www.ericmmartin.com/projects/simplemodal/
 * http://code.google.com/p/simplemodal/
 *
 * Copyright (c) 2010 Eric Martin - http://ericmmartin.com
 *
 * Licensed under the MIT license:
 *   http://www.opensource.org/licenses/mit-license.php
 *
 * Revision: $Id: rollout.js 238 2010-03-11 05:56:57Z emartin24 $
 */

jQuery(function ($) {

	var rollout = {
		container: null,
		init: function () {
			$("input.rollout, a.rollout").click(function (e) {
				e.preventDefault();	
				$modal = $(this).attr('data-modal')

				$("#rollout-modal-content[data-modal = " + $modal + "]").modal({
					overlayId: 'rollout-overlay',
					containerId: 'rollout-container',
					closeHTML: null,
					minHeight: 80,
					opacity: 65, 
					position: ['40px'],
					overlayClose: true,
					onOpen: rollout.open,
					onClose: rollout.close
				});
			});
		},
		open: function (d) {
			var self = this;
			self.container = d.container[0];
			d.overlay.fadeIn('slow', function () {
				$("#rollout-modal-content[data-modal = " + $modal + "]", self.container).show();
				var title = $("#rollout-modal-title", self.container);
				title.show();
				d.container.slideDown('slow', function () {
					setTimeout(function () {
						var h = $("#rollout-modal-data", self.container).height()
							+ title.height()
							+ 20; // padding
						d.container.animate(
							{height: h}, 
							200,
							function () {
								$("div.close", self.container).show();
								$("#rollout-modal-data", self.container).show();
							}
						);
					}, 300);
				});
			})
		},
		close: function (d) {
			var self = this; // this = SimpleModal object
			d.container.animate(
				{top:"-" + (d.container.height() + 20)},
				500,
				function () {
					self.close(); // or $.modal.close();
				}
			);
		}
	};

	rollout.init();

});


