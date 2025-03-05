// import { defineConfig } from 'vite'
// import react from '@vitejs/plugin-react'

// // https://vite.dev/config/
// export default defineConfig({
//   build:{
//     rollupOptions:{
//       output:{
//         manualChunks:{
//           pdfjs: ['pdfjs_dist'],
//         }
//       }
//     }
//   },
//   chunkSizeWarningLimit: 1000,
//   plugins: [react()],
// });
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
  },
  build: {
    chunkSizeWarningLimit: 1000, // Aumenta el límite de advertencia de tamaño de chunk
    rollupOptions: {
      output: {
        manualChunks(id) {
          if (id.includes('node_modules')) {
            return 'vendor';
          }
        },
      },
    },
  },
});
