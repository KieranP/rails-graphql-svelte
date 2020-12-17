<script>
  import { Modal } from 'bootstrap/dist/js/bootstrap.esm'
  import { createEventDispatcher } from 'svelte'
  const dispatch = createEventDispatcher()

  function confirm() {
    var dialog = document.getElementById('confirmDialog')
    var modal = Modal.getInstance(dialog)
    modal.hide()

    dispatch('confirm')
  }

  export let title = 'Are you sure?'
</script>

<div class="modal fade" id="confirmDialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{title}</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-danger" on:click={confirm}>Proceed</button>
      </div>
    </div>
  </div>
</div>
