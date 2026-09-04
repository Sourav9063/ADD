---
name: file-upload
description: Build or review file upload. Use when adding a file picker, dropzone, drag-and-drop upload, image or avatar upload with cropping, multi-file queues, upload progress, retry and cancel, or when handling file type, size limits, and upload errors.
---

# File Upload

Assumes `design-foundations` for tokens and `feedback-design` for progress and errors.
Upload is a long-running, frequently failing operation dressed as a form field; design the
failure path first.

## The control

- **Click and drop, always both.** A dropzone with no button excludes anyone not using a mouse; a button with no dropzone ignores what most people try first.
- The visible control is a real `<button>` or label tied to a hidden `<input type="file">`, never a bare styled `div`. Keep the input focusable and keyboard-activatable, not `display: none` in a way that removes it from the accessibility tree.
- **State the rules before the attempt**: accepted types, maximum size, maximum count, and any dimension or duration limits, as visible text under the control. Discovering a 5MB limit after a 4-minute upload is the defining failure of this component.
- Set `accept` to filter the picker, and still validate on the client *and* the server - `accept` is a hint, not a constraint.
- The dropzone changes state on drag-over (border, fill, and a label change) so the target is unmistakable **before** release, and reverts on drag-leave and drop.
- Support paste from clipboard where images are the point; support a URL field where the source is often remote.

## The queue

- Every file is a row: thumbnail or type icon, name, size, per-file progress, and a per-file cancel and retry. A filename alone is not confirmation that the right file was chosen.
- **Show real progress**: percent complete plus a rate or time remaining for anything large. A bare indeterminate spinner for a 200MB upload tells the user nothing about whether to wait.
- One file failing must never take the queue down. Keep successful uploads, mark the failure inline with its reason, and retry that file alone without re-selecting it.
- Cancel actually aborts the request and cleans up the partial upload; it does not just hide the row.
- Rejections are per-file and specific: "logo.tiff - unsupported type, use PNG or JPG", "video.mp4 - 240MB exceeds the 100MB limit". Never reject the whole selection because one file was wrong.
- Uploading continues across in-app navigation where the platform allows it, with a persistent indicator; warn before a tab close that would abort it.

## Images and avatars

- Preview at the size and shape it will actually be used - a circular avatar cropped from a square preview surprises people at the edges.
- Offer cropping and rotation in place, with the crop frame draggable and zoomable, and a keyboard path for both. Never require an external tool to meet an aspect ratio.
- Downscale and compress client-side before upload when the target is a web image; a 12MP phone photo for a 96px avatar wastes the user's bandwidth and your storage.
- Strip or explicitly retain EXIF, and honor orientation so portrait photos do not land sideways.
- Ask for alt text at the point of upload when the image will be published (`media-design`).

## After upload

- Confirm with the stored result, not with the local file: the server's thumbnail, name, and size, plus a link to the file.
- Replace and remove are both available afterward, and remove asks for confirmation only when the file is already referenced elsewhere (`feedback-design` prefers undo).
- Preserve the rest of the form while an upload runs; never block the submit button silently - say "Waiting for 1 upload to finish".

## Accessibility

- **Dragging is never the only path.** WCAG 2.2 requires a single-pointer alternative for any drag operation, which the file picker button satisfies - so it must be genuinely usable, not visually hidden.
- The input has a real label; the dropzone's instructions are its `aria-describedby`, not floating text with no association.
- Progress uses `role="progressbar"` with `aria-valuenow`, and completion, failure, and rejection are announced politely once per file - not on every percentage tick.
- Keep the file list a real list with each row's controls named by file ("Retry logo.png"), so a screen-reader user can act on a specific item.
- Do not rely on drag-over color alone to indicate the target state; change the label text too.
