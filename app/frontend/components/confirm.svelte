<script lang="ts">
  import Modal from 'bootstrap/js/dist/modal'
  import { createEventDispatcher } from 'svelte'
  const dispatch = createEventDispatcher()
  import { _ } from '@libs/i18n'

  let dialog: HTMLDivElement

  function confirm() {
    var modal = Modal.getInstance(dialog)
    modal?.hide()

    dispatch('confirm')
  }

  export let title = $_('components.confirm.title')
</script>

<div class="modal fade" id="confirmDialog" bind:this={dialog}>
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{title}</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" />
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          {$_('components.confirm.cancel')}
        </button>
        <button type="button" class="btn btn-danger" on:click={confirm}>
          {$_('components.confirm.proceed')}
        </button>
      </div>
    </div>
  </div>
</div>
