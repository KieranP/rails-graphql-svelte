<script lang="ts">
  import Modal from 'bootstrap/js/dist/modal'

  import { _ } from '$lib/helpers/i18n'

  interface Props {
    onconfirm: () => void
    title?: string
  }

  let { onconfirm, title = $_('components.confirm.title') }: Props = $props()

  let dialog: HTMLDivElement

  function confirm() {
    var modal = Modal.getInstance(dialog)
    modal?.hide()
    onconfirm()
  }
</script>

<div class="modal fade" id="confirmDialog" bind:this={dialog}>
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{title}</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"
        ></button>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          {$_('components.confirm.cancel')}
        </button>
        <button type="button" class="btn btn-danger" onclick={confirm}>
          {$_('components.confirm.proceed')}
        </button>
      </div>
    </div>
  </div>
</div>
