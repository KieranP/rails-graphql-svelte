<script lang="ts">
  import Modal from 'bootstrap/js/dist/modal'

  import { _ } from '$lib/helpers/i18n'

  interface Props {
    onconfirm: () => void
    title?: string
  }

  const { onconfirm, title = $_('components.confirm.title') }: Props = $props()

  let dialog: HTMLDivElement | undefined = $state()

  function confirm(): void {
    if (!dialog) return

    const modal = Modal.getInstance(dialog)
    modal?.hide()
    onconfirm()
  }
</script>

<div
  bind:this={dialog}
  id="confirmDialog"
  class="modal fade"
>
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{title}</h5>
        <button
          class="btn-close"
          aria-label="Close"
          data-bs-dismiss="modal"
          type="button"
        ></button>
      </div>
      <div class="modal-footer">
        <button
          class="btn btn-secondary"
          data-bs-dismiss="modal"
          type="button"
        >
          {$_('components.confirm.cancel')}
        </button>
        <button
          class="btn btn-danger"
          onclick={confirm}
          type="button"
        >
          {$_('components.confirm.proceed')}
        </button>
      </div>
    </div>
  </div>
</div>
